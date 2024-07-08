import '../../../domain/entities/movie.dart';

abstract class TopRatedMoviesState{}

class TopRatedMoviesInitial extends TopRatedMoviesState{}
class TopRatedMoviesLoading extends TopRatedMoviesState{}

class TopRatedMoviesLoaded extends TopRatedMoviesState{
  final List<Movie> movies;

  TopRatedMoviesLoaded(this.movies);
}

class TopRatedMoviesError extends TopRatedMoviesState{
  final String message;

  TopRatedMoviesError(this.message);
}