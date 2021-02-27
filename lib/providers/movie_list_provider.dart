import 'package:flutter/material.dart';
import 'package:movie_client_app/keys.dart';
import 'package:movie_client_app/models/movie_dto.dart';

class MovieListProvider extends ChangeNotifier {
  List<MovieDto> _nowMovies = [];

  List<MovieDto> get nowMovies => [..._nowMovies];

  Future<void> fetchAndSetNowMovies() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    String url =
        'https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=${Keys.apiKey}';
    _nowMovies = null;
  }
}
