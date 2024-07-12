import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie_app/presentation/bloc/popular_movies/popular_movies_state.dart';
import 'package:movie_app/presentation/bloc/top_rated_movies/top_rated_movies_bloc.dart';
import 'package:movie_app/presentation/bloc/top_rated_movies/top_rated_movies_state.dart';
import 'package:movie_app/presentation/bloc/search_movies/search_movies_bloc.dart';
import 'package:movie_app/presentation/pages/movie_list.dart';
import 'package:movie_app/presentation/pages/search_screen/search_screen.dart';
import '../../domain/repositories/movie_repository.dart';
import '../../domain/usecases/search_movies.dart';
import '../bloc/search_movies/search_movies_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  final bckImage = 'https://i.pinimg.com/736x/8b/5d/20/8b5d20a03cb468cc9e2506fd0fe21f51.jpg';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: false,
              elevation: 0,
              toolbarHeight: 100,
              backgroundColor: Colors.brown[300],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.brown[300],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Hammad 👋',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'TDD - Movie App',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => SearchMoviesBloc(
                              searchMovies: SearchMovies(
                                RepositoryProvider.of<MovieRepository>(context),
                              ),
                            )..add(FetchSearchMovies('')),
                            child: SearchScreen(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    height: 290,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(bckImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                child: Text('Developed By Hammad'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20), // Border radius
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),

                  // Top Rated Movies
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Top Rated Movies',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                    builder: (context, state) {
                      if (state is TopRatedMoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is TopRatedMoviesLoaded) {
                        return MoviesList(movies: state.movies);
                      } else if (state is TopRatedMoviesError) {
                        return Center(child: Text(state.message));
                      }
                      return Container();
                    },
                  ),

                  SizedBox(height: 20,),

                  // Popular Movies
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Popular Movies',
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                    builder: (context, state) {
                      if (state is PopularMoviesLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is PopularMoviesLoaded) {
                        return MoviesList(movies: state.movies);
                      } else if (state is PopularMoviesError) {
                        return Center(child: Text(state.message));
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
