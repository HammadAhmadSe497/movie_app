
import '../entities/movie.dart';

abstract class MovieRepository {

  Future<List<Movie>> getPopularMovies();
  Future<List<Movie>> getTopRatedMovies();
  Future<List<Movie>> searchMovies(String query);
 // Future<List<Movie>> getNowPlayingMovies();


}



