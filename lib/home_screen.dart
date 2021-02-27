import 'package:flutter/material.dart';
import 'package:movie_client_app/star.dart';

class HomeScreen extends StatelessWidget {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '현재 상영중',
          style: _theme.textTheme.subtitle2,
        ),
        Container(
          height: 200,
          margin: EdgeInsets.only(top: 16, bottom: 40),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 8,
            itemBuilder: (ctx, i) {
              return Padding(
                padding: const EdgeInsets.only(right: 17.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 100,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original/3GW0A72MxsSgghqpjc2O2MvO8Ec.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      'Test',
                      style: TextStyle(fontSize: 12),
                    ),
                    Star(),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
          child: Column(
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
          child: Column(
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
          child: Column(
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
      padding: const EdgeInsets.only(bottom: 8.0),
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
                Star(),
                Row(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
