import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_client_app/keys.dart';

class DetailMovieProvider extends ChangeNotifier {
  Map<String, dynamic> _movieDetail = {};

  UnmodifiableMapView<String, dynamic> get movieDetail =>
      UnmodifiableMapView(_movieDetail);

  Future<void> fetchDetailMovieById(int id) async {
    String url =
        'https://api.themoviedb.org/3/movie/${id.toString()}?language=ko-KR'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    _movieDetail = json.decode(response.body);
    notifyListeners();
  }
}
