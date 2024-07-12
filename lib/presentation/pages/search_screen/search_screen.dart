import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/domain/usecases/search_movies.dart';
import 'package:movie_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app/presentation/bloc/search_movies/search_movies_event.dart';
import 'package:movie_app/presentation/bloc/search_movies/search_movies_state.dart';
import 'package:movie_app/presentation/pages/movie_list.dart';
import 'package:movie_app/presentation/widgets/movie_card.dart';
import 'package:movie_app/domain/entities/movie.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search movies...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          onChanged: (query) {
            context.read<SearchMoviesBloc>()..add(FetchSearchMovies(query));  // Correct event name
          },
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
          builder: (context, state) {
            if (state is SearchMoviesInitial) {
              return Text('Start searching...', style: TextStyle(color: Colors.white));
            } else if (state is SearchMoviesLoading) {
              return CircularProgressIndicator();
            } else if (state is SearchMoviesLoaded) {
              return _buildSearchResults(state.movies);  // Correct state.movies
            } else if (state is SearchMoviesError) {
              return Text(state.message, style: TextStyle(color: Colors.red));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<Movie> movies) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movies[index]);  // Added 'movie:' to avoid error
      },
    );
  }
}
