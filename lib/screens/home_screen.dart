import 'package:flutter/material.dart';
import 'package:movie_client_app/models/movie_dto.dart';
import 'package:movie_client_app/providers/home_movies_provider.dart';
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
    doFutureInit();
  }

  Future<void> doFutureInit() async {
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
    } catch (error) {} finally {
      setState(() {
        _nowMovieLoading = false;
        _notYetMovieLoading = false;
        _popularMovieLoading = false;
        _highRateMovieLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
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
                _buildNotYetMovie(_theme),
                _buildPopularMovie(_theme),
                _buildHighRateMovie(_theme),
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
                    itemCount: provider.nowMovies.length,
                    itemBuilder: (ctx, i) {
                      final movie = provider.nowMovies[i];
                      return Container(
                        margin: EdgeInsets.only(right: 17.0),
                        width: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 160,
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
                                  : Image.network(
                                      'https://image.tmdb.org/t/p/original${movie.posterPath}',
                                      fit: BoxFit.cover,
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
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotYetMovie(ThemeData _theme) {
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
                            provider.notYetMovies[i], provider.genres),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularMovie(ThemeData _theme) {
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
                            provider.popularMovies[i], provider.genres),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighRateMovie(ThemeData _theme) {
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
                            provider.highRateMovies[i], provider.genres),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieBlock(MovieDto movie, Map<int, String> genres) {
    return Padding(
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
                : Image.network(
                    'https://image.tmdb.org/t/p/original${movie.posterPath}',
                    fit: BoxFit.cover,
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
                        width: 200,
                        child: Row(
                          children: [
                            for (int i = 0; i < movie.genreIds.length; i++)
                              Text(
                                genres[movie.genreIds[i]] +
                                    (i == movie.genreIds.length - 1
                                        ? ''
                                        : ', '),
                                style: TextStyle(fontSize: 9),
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
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
    );
  }
}
