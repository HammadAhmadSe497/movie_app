import 'package:dartz/dartz.dart';

import 'package:movie_app/core_errors/server_failure.dart';

import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class SearchMovies{
  final MovieRepository repository;

  SearchMovies(this.repository);

  Future<Either<Failure, List<Movie>>> call(String query) async {
    return await repository.searchMovies(query);
  }
}