import 'package:movie_app/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/presentation/bloc/top_rated_movies/top_rated_movie_event.dart';
import 'package:movie_app/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState>{
  final GetTopRatedMovies getTopRatedMovies;

  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(TopRatedMoviesInitial()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final failureOrMovies = await getTopRatedMovies();
      failureOrMovies.fold(
              (failure) => emit(TopRatedMoviesError(failure.toString())),
              (movies) => emit(TopRatedMoviesLoaded(movies)));
    });
  }
}