import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/domain/entities/movie.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_popular_movies.dart';
import 'package:mockito/annotations.dart';

import 'get_popular_movies_test.mocks.dart';


@GenerateNiceMocks([MockSpec<MovieRepository>()])

void main() {

  // arrange
late   GetPopularMovies usecase;
late   MockMovieRepository mockMovieRepository;


  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetPopularMovies(mockMovieRepository);
  });
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


test('should get popular movies from the repository', () async {
  when(mockMovieRepository.getPopularMovies())
      .thenAnswer((_) async => Right(tMovieList));
  // act
  final result = await usecase();
  // assert
  expect(result, equals(Right(tMovieList)));
  verify(mockMovieRepository.getPopularMovies());
  verifyNoMoreInteractions(mockMovieRepository);
});
}

