import 'package:movie_app/domain/usecases/get_top_rated_movies.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/popular_movies/popular_movie_event.dart';
import 'package:movie_app/presentation/bloc/popular_movies/popular_movies_state.dart';

import '../../../domain/usecases/get_popular_movies.dart';



class PopularMoviesBloc extends Bloc<PopularMovieEvent, PopularMoviesState>{
  final GetPopularMovies getPopularMovies;

  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesInitial()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(PopularMoviesLoading());
      final failureOrMovies = await getPopularMovies();
      failureOrMovies.fold(
              (failure) => emit(PopularMoviesError(failure.toString())),
              (movies) => emit(PopularMoviesLoaded(movies)));
    });
  }
}