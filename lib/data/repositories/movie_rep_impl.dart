
import 'package:movie_app/data/models/movie_models.dart';
import 'package:movie_app/domain/entities/movie.dart';

import '../../core_errors/server_exception.dart';
import '../../core_errors/server_failure.dart';
import '../../domain/repositories/movie_repository.dart';
import '../datasources/movie_remote_data_source.dart';
import 'package:dartz/dartz.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl({required this.remoteDataSource});

  @override

  Future<Either<ServerFailure,List<Movie>>>getPopularMovies() async{
    try{
      final List<MovieModels> movieModels = await remoteDataSource.getPopularMovies();
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure,List<Movie>>>getTopRatedMovies() async{
    try{
      final List<MovieModels> movieModels = await remoteDataSource.getTopRatedMovies();
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<ServerFailure,List<Movie>>>searchMovies(String query) async{
    try{
      final List<MovieModels> movieModels = await remoteDataSource.searchMovies(query);
      final List<Movie> movies = movieModels.map((model) => model.toEntity()).toList();
      return Right(movies);
    }on ServerException{
      return Left(ServerFailure());
    }
  }

}