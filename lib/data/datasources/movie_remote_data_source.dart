

import '../models/movie_models.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModels>> getPopularMovies();
  Future<List<MovieModels>> getTopRatedMovies();
  Future<List<MovieModels>> searchMovies(String query);

}
