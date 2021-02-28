import 'package:flutter/material.dart';
import 'package:movie_client_app/providers/detail_movie_provider.dart';
import 'package:movie_client_app/widgets/star.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _doFutureInit();
  }

  Future<void> _doFutureInit() async {
    try {
      await Provider.of<DetailMovieProvider>(context, listen: false)
          .fetchAndSetDetailMovie();
      await Provider.of<DetailMovieProvider>(context, listen: false)
          .fetchAndSetMovieActors();
      await Provider.of<DetailMovieProvider>(context, listen: false)
          .fetchAndSetMovieReviews();
      _isLoading = false;
    } catch (error) {}
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    final _movie =
        Provider.of<DetailMovieProvider>(context, listen: false).movie;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: _screenSize.height,
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.center,
                widthFactor: 1,
                heightFactor: 0.55,
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${_movie.posterPath}',
                  color: Colors.black38,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Positioned(
              top: 190,
              child: Container(
                height: _screenSize.height,
                width: _screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
              ),
            ),
            Consumer<DetailMovieProvider>(
              builder: (ctx, provider, child) =>
                  _buildContents(_screenSize, provider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(Size _screenSize, DetailMovieProvider provider) {
    String movieGenres = '';
    if (!_isLoading) {
      for (int i = 0; i < provider.movieDetail['genres'].length; i++) {
        movieGenres += provider.movieDetail['genres'][i]['name'] +
            (i == provider.movieDetail['genres'].length - 1 ? '' : ', ');
      }
    }
    return Container(
      margin: EdgeInsets.only(top: 140),
      width: _screenSize.width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeadContents(_screenSize, provider, movieGenres),
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOverview(provider),
                    _buildActor(provider),
                    _buildReview(provider),
                  ],
                ),
        ],
      ),
    );
  }

  Row _buildHeadContents(
      Size _screenSize, DetailMovieProvider provider, String movieGenres) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 180,
          width: 110,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://image.tmdb.org/t/p/original${provider.movie.posterPath}',
              fit: BoxFit.fill,
            ),
          ),
        ),
        _isLoading
            ? CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: SizedBox(
                  width: _screenSize.width * 0.45,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.movieDetail['title'],
                      ),
                      provider.movieDetail['adult'] == false
                          ? SizedBox(
                              height: 16,
                            )
                          : Text(
                              provider.movieDetail['adult'].toString(),
                            ),
                      Text(
                        movieGenres,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${provider.movie.releaseDate} 발매',
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Star(provider.movie.voteAverage),
                          Text(
                            provider.movie.voteAverage.toString(),
                            style: TextStyle(color: Colors.amber),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  Container _buildOverview(DetailMovieProvider provider) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('개요'),
          Text(provider.movieDetail['overview']),
        ],
      ),
    );
  }

  Container _buildActor(DetailMovieProvider provider) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('주요 출연진'),
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.movieActors.length,
              itemBuilder: (ctx, i) {
                final Map<String, dynamic> actor = provider.movieActors[i];
                return SizedBox(
                  width: 60,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: Image.network(
                          'https://image.tmdb.org/t/p/original${actor['profile_path']}',
                        ).image,
                        radius: 20,
                      ),
                      Text(
                        actor['name'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 8),
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

  Container _buildReview(DetailMovieProvider provider) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('리뷰'),
          for (int i = 0; i < provider.movieReviews.length; i++)
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      provider.movieReviews[i]['content'],
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      child: Text(
                        provider.movieReviews[i]['author'],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
