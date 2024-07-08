

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/core_errors/server_exception.dart';
import 'package:movie_app/core_errors/server_failure.dart';
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/data/models/movie_models.dart';
import 'package:movie_app/data/repositories/movie_rep_impl.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';

import '../../domain_usecases/get_popular_movies_test.mocks.dart';
import 'movie_rep_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<MovieRemoteDataSource>()])

void main(){
 late  MovieRepositoryImpl repository;
  late MockMovieRemoteDataSource mockMovieRemoteDataSource;

  setUp(() {
    mockMovieRemoteDataSource = MockMovieRemoteDataSource();
    repository = MovieRepositoryImpl(
        remoteDataSource: mockMovieRemoteDataSource

    );
  });

  final tMovieModelsList = [
    MovieModels(
      id: 1,
      title: 'Movie 1',
      overview: 'Overview 1',
      posterPath: 'Poster Path 1',
    ),
    MovieModels(
      id: 2,
      title: 'Movie 2',
      overview: 'Overview 2',
      posterPath: 'Poster Path 2',
    ),
  ];
  final tMovieList = [
    Movie(
      id: 1,
      title: 'Movie 1',
      overview: 'Overview 1',
      posterPath: 'Poster Path 1',
    ),
    Movie(
      id: 2,
      title: 'Movie 2',
      overview: 'Overview 2',
      posterPath: 'Poster Path 2',
    ),
  ];
  
  final tQuery = 'inception';

  test('should get top rated movies from the remote data source', () async{
    // arrange
    when(mockMovieRemoteDataSource.getTopRatedMovies())
        .thenAnswer((_) async => tMovieModelsList);
    // act
    final result = await repository.getTopRatedMovies();
    // assert
    expect(result,isA<Right<Failure,List<Movie>>>());


  });

  test('should get Popular movies from the remote data source', () async{
    // arrange
    when(mockMovieRemoteDataSource.getPopularMovies())
        .thenAnswer((_) async => tMovieModelsList);
    // act
    final result = await repository.getPopularMovies();
    // assert
    expect(result, isA<Right<Failure,List<Movie>>>());

  });

  test('should Search movies from the remote data source', () async{
    // arrange
    when(mockMovieRemoteDataSource.searchMovies(tQuery))
        .thenAnswer((_) async => tMovieModelsList);
    // act
    final result = await repository.searchMovies(tQuery);
    // assert
    expect(result,isA<Right<Failure,List<Movie>>>());


  });
 test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
   when(mockMovieRemoteDataSource.getPopularMovies())
       .thenThrow(ServerException());

   final result = await repository.getPopularMovies();

   expect(result, isA<Left<ServerFailure, List<Movie>>>());
 });

 test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
   when(mockMovieRemoteDataSource.getTopRatedMovies())
       .thenThrow(ServerException());

   final result = await repository.getTopRatedMovies();

   expect(result, isA<Left<ServerFailure, List<Movie>>>());
 });

 test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
   when(mockMovieRemoteDataSource.searchMovies(tQuery))
       .thenThrow(ServerException());

   final result = await repository.searchMovies(tQuery);

   expect(result, isA<Left<ServerFailure, List<Movie>>>());
 });
 //


}