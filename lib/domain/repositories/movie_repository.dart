
import 'package:movie_app/data/models/movie_models.dart';

import '../../core_errors/server_failure.dart';
import '../entities/movie.dart';
import 'package:dartz/dartz.dart';


abstract class MovieRepository {

  Future<Either<Failure,List<Movie>>> getPopularMovies();
  Future<Either<Failure,List<Movie>>> getTopRatedMovies();
  Future<Either<Failure,List<Movie>>> searchMovies(String query);


}



