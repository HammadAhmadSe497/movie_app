
import 'package:get_it/get_it.dart';
import 'package:movie_app/data/repositories/movie_rep_impl.dart';
import 'package:movie_app/domain/repositories/movie_repository.dart';
import 'package:movie_app/domain/usecases/get_popular_movies.dart';

import '../../data/datasources/movie_remote_data_source.dart';
import '../../data/datasources/remote/movie_remote_data_source_impl.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/search_movies.dart';
import '../bloc/popular_movies/popular_movies_bloc.dart';
import '../bloc/search_movies/search_movies_bloc.dart';
import '../bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;
void init(){
  //bloc
  getIt.registerFactory(() => PopularMoviesBloc(getPopularMovies: getIt()));
  getIt.registerFactory(() => TopRatedMoviesBloc(getTopRatedMovies: getIt()));
  getIt.registerFactory(() => SearchMoviesBloc(searchMovies: getIt()));


  //use cases
  getIt.registerLazySingleton(() => GetPopularMovies( getIt()));
  getIt.registerLazySingleton(() => GetTopRatedMovies( getIt()));
  getIt.registerLazySingleton(() => SearchMovies( getIt()));


  //repository
  getIt.registerLazySingleton<MovieRepository>(() =>MovieRepositoryImpl(remoteDataSource: getIt()));

  //datasources
   getIt.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: getIt()));

  //http services
   getIt.registerLazySingleton(() => http.Client());
}