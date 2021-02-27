import 'package:flutter/material.dart';
import 'package:movie_client_app/providers/now_movies_provider.dart';
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
      await Provider.of<NowMoviesProvider>(context, listen: false)
          .fetchAndSetNowMovies();
      setState(() {
        _nowMovieLoading = false;
      });
//      await Provider.of<MovieListProvider>(context, listen: false)
//          .fetchAndSetNowMovies();
//      setState(() {
//        _nowMovieLoading = false;
//      });
//      await Provider.of<MovieListProvider>(context, listen: false)
//          .fetchAndSetNowMovies();
//      setState(() {
//        _nowMovieLoading = false;
//      });
//      await Provider.of<MovieListProvider>(context, listen: false)
//          .fetchAndSetNowMovies();
//      setState(() {
//        _nowMovieLoading = false;
//      });
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
    return Consumer<NowMoviesProvider>(
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
                      return Padding(
                        padding: EdgeInsets.only(right: 17.0),
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
                                  : Image.network(
                                      'https://image.tmdb.org/t/p/original${movie.posterPath}',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 7),
                              child: Text(
                                movie.title,
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
    return Column(
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
                    for (int i = 0; i < 3; i++) _buildMovieBlock(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildPopularMovie(ThemeData _theme) {
    return Column(
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
                    for (int i = 0; i < 3; i++) _buildMovieBlock(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildHighRateMovie(ThemeData _theme) {
    return Column(
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
                    for (int i = 0; i < 3; i++) _buildMovieBlock(),
                  ],
                ),
        ),
      ],
    );
  }

  Widget _buildMovieBlock() {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 45,
            margin: EdgeInsets.only(right: 16),
            child: Image.network(
              'https://image.tmdb.org/t/p/original/3GW0A72MxsSgghqpjc2O2MvO8Ec.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '11',
                  style: TextStyle(fontSize: 10),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Star(3),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          '22',
                          style: TextStyle(fontSize: 9),
                        ),
                      ),
                      Text(
                        'date',
                        style: TextStyle(fontSize: 9),
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
