import 'package:flutter/material.dart';

class MovieListProvider extends ChangeNotifier {
  List<int> _nowMovies = [];

  List<int> get nowMovies => [..._nowMovies];

  Future<void> fetchAndSetNowMovies() async {
    await Future.delayed(
      Duration(seconds: 3),
    );
    _nowMovies = [1, 2, 3];
  }
}
