import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/data/datasources/movie_remote_data_source.dart';
import '../../../core_errors/server_exception.dart';
import '../../models/movie_models.dart';
import 'package:mockito/src/mock.dart';


class MovieRemoteDataSourceImpl implements MovieRemoteDataSource{
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  static const BASE_URL = "https://api.themoviedb.org/3";
  static const API_KEY = "b2777254c6e459ace41f98523d2815a1";

  @override
  Future<List<MovieModels>> getPopularMovies() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/movie/popular?api_key=$API_KEY"),
    );

    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      final List<MovieModels> movies = (responseBody['results'] as List)
          .map((movie) => MovieModels.fromJson(movie))
          .toList();
      return movies;
    }else{
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModels>> getTopRatedMovies() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/movie/top_rated?api_key=$API_KEY"),
    );

    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      final List<MovieModels> movies = (responseBody['results'] as List)
          .map((movie) => MovieModels.fromJson(movie))
          .toList();
      return movies;
    }else{
      throw ServerException();
    }
  }


  @override
  Future<List<MovieModels>>searchMovies( String query) async {
    final response = await client.get(
      Uri.parse("$BASE_URL/search/movie?query=$query&api_key=$API_KEY"),
    );

    if(response.statusCode == 200){
      final responseBody = json.decode(response.body);
      final List<MovieModels> movies = (responseBody['results'] as List)
          .map((movie) => MovieModels.fromJson(movie))
          .toList();
      return movies;
    }else{
      throw ServerException();
    }
  }

}