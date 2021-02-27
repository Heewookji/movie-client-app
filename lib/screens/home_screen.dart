import 'package:flutter/material.dart';
import 'package:movie_client_app/models/movie_dto.dart';
import 'package:movie_client_app/providers/detail_movie_provider.dart';
import 'package:movie_client_app/providers/home_movies_provider.dart';
import 'package:movie_client_app/screens/detail_screen.dart';
import 'package:movie_client_app/widgets/star.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _nowMovieLoading = false;
  bool _notYetMovieLoading = false;
  bool _popularMovieLoading = false;
  bool _highRateMovieLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _nowMovieLoading = true;
      _notYetMovieLoading = true;
      _popularMovieLoading = true;
      _highRateMovieLoading = true;
    });
    _doFutureInit();
  }

  Future<void> _doFutureInit() async {
    try {
      await Provider.of<HomeMoviesProvider>(context, listen: false)
          .fetchAndSetGenres();
      await Provider.of<HomeMoviesProvider>(context, listen: false)
          .fetchAndSetNowMovies();
      _nowMovieLoading = false;
      await Provider.of<HomeMoviesProvider>(context, listen: false)
          .fetchAndSetNotYetMovies();
      _notYetMovieLoading = false;
      await Provider.of<HomeMoviesProvider>(context, listen: false)
          .fetchAndSetPopularMovies();
      _popularMovieLoading = false;
      await Provider.of<HomeMoviesProvider>(context, listen: false)
          .fetchAndSetHighRateMovies();
      _highRateMovieLoading = false;
    } catch (error) {}
  }

  void _navigateToDetail(MovieDto movie, String movieGenres) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ChangeNotifierProvider(
          create: (ctx) => DetailMovieProvider(movie),
          child: DetailScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    Size _screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 23,
            ),
            child: Column(
              children: [
                _buildNowMovie(_theme),
                _buildNotYetMovie(_theme, _screenSize),
                _buildPopularMovie(_theme, _screenSize),
                _buildHighRateMovie(_theme, _screenSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNowMovie(ThemeData _theme) {
    return Consumer<HomeMoviesProvider>(
      builder: (ctx, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '현재 상영중',
            style: _theme.textTheme.subtitle2,
          ),
          Container(
            height: 200,
            margin: EdgeInsets.only(top: 16, bottom: 40),
            child: _nowMovieLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    cacheExtent: 100,
                    itemCount: provider.nowMovies.length,
                    itemBuilder: (ctx, i) {
                      final movie = provider.nowMovies[i];
                      String movieGenres = '';
                      for (int i = 0; i < movie.genreIds.length; i++) {
                        movieGenres += provider.genres[movie.genreIds[i]] +
                            (i == movie.genreIds.length - 1 ? '' : ', ');
                      }
                      return GestureDetector(
                        onTap: () => _navigateToDetail(movie, movieGenres),
                        child: Container(
                          margin: EdgeInsets.only(right: 17.0),
                          width: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 160,
                                width: 100,
                                child: movie.posterPath == null
                                    ? Container(
                                        color: Colors.black26,
                                        child: Center(
                                          child: Text(
                                            '정보가 없습니다',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.4),
                                              spreadRadius: 1,
                                              blurRadius: 4,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            'https://image.tmdb.org/t/p/original${movie.posterPath}',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(
                                  movie.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Star(movie.voteAverage),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotYetMovie(ThemeData _theme, Size _screenSize) {
    return Consumer<HomeMoviesProvider>(
      builder: (ctx, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '개봉 예정',
            style: _theme.textTheme.subtitle2,
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 24),
            height: 235,
            child: _notYetMovieLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      for (int i = 0; i < 3; i++)
                        _buildMovieBlock(
                          _screenSize,
                          provider.notYetMovies[i],
                          provider.genres,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularMovie(ThemeData _theme, Size _screenSize) {
    return Consumer<HomeMoviesProvider>(
      builder: (ctx, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '인기',
            style: _theme.textTheme.subtitle2,
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 24),
            height: 235,
            child: _popularMovieLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      for (int i = 0; i < 3; i++)
                        _buildMovieBlock(
                          _screenSize,
                          provider.popularMovies[i],
                          provider.genres,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighRateMovie(ThemeData _theme, Size _screenSize) {
    return Consumer<HomeMoviesProvider>(
      builder: (ctx, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '높은 평점',
            style: _theme.textTheme.subtitle2,
          ),
          Container(
            margin: EdgeInsets.only(top: 16, bottom: 24),
            height: 235,
            child: _highRateMovieLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      for (int i = 0; i < 3; i++)
                        _buildMovieBlock(
                          _screenSize,
                          provider.highRateMovies[i],
                          provider.genres,
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieBlock(
      Size _screenSize, MovieDto movie, Map<int, String> genres) {
    String movieGenres = '';
    for (int i = 0; i < movie.genreIds.length; i++) {
      movieGenres += genres[movie.genreIds[i]] +
          (i == movie.genreIds.length - 1 ? '' : ', ');
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => _navigateToDetail(movie, movieGenres),
      child: Padding(
        padding: EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 70,
              width: 45,
              margin: EdgeInsets.only(right: 16),
              child: movie.posterPath == null
                  ? Container(
                      color: Colors.black26,
                      child: Center(
                        child: Text(
                          '정보가 없습니다',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4.0),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original${movie.posterPath}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(fontSize: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 4),
                    child: Star(movie.voteAverage),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: _screenSize.width * 0.45,
                          child: Text(
                            movieGenres,
                            style: TextStyle(fontSize: 9),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 50,
                          child: Text(
                            movie.releaseDate,
                            style: TextStyle(fontSize: 9),
                          ),
                        ),
                      ],
                    ),
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
