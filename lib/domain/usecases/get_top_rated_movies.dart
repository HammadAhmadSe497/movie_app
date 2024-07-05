
import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class GetTopRatedMovies{

   final MovieRepository repository;

   GetTopRatedMovies(this.repository);

  Future<List<Movie>> call() async {
    return await repository.getTopRatedMovies();
  }
}