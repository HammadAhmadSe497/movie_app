
import 'package:dartz/dartz.dart';

import 'package:movie_app/core_errors/server_failure.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMovies{

   final MovieRepository repository;

   GetTopRatedMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call() async {
    return await repository.getTopRatedMovies();
  }
}