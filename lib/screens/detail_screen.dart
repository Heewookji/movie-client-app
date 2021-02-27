import 'package:flutter/material.dart';
import 'package:movie_client_app/models/movie_dto.dart';
import 'package:movie_client_app/widgets/star.dart';

class DetailScreen extends StatefulWidget {
  final MovieDto movie;
  final String genres;

  DetailScreen(this.movie, this.genres);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
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
                heightFactor: 0.4,
                child: Image.network(
                  'https://image.tmdb.org/t/p/original${widget.movie.posterPath}',
                  color: Colors.black38,
                  colorBlendMode: BlendMode.darken,
                ),
              ),
            ),
            Positioned(
              top: 190,
              child: Container(
                height: 100,
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
            _buildContents(_screenSize),
          ],
        ),
      ),
    );
  }

  Widget _buildContents(Size _screenSize) {
    return Positioned(
      top: 140,
      child: Container(
        width: _screenSize.width,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 160,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
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
                      'https://image.tmdb.org/t/p/original${widget.movie.posterPath}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: SizedBox(
                    width: _screenSize.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.movie.title),
                        Text(widget.movie.adult.toString()),
                        Text(
                          widget.genres,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('${widget.movie.releaseDate} 발매'),
                        Row(
                          children: [
                            Star(widget.movie.voteAverage),
                            Text(
                              widget.movie.voteAverage.toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('개요'),
                  Text(widget.movie.overview),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('주요 출연진'),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('리뷰'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
