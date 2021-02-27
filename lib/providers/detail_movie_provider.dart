import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_client_app/keys.dart';
import 'package:movie_client_app/models/movie_dto.dart';

class DetailMovieProvider extends ChangeNotifier {
  MovieDto movie;
  Map<String, dynamic> _movieDetail = {};
  List<Map<String, dynamic>> _movieActors = [];

  DetailMovieProvider(this.movie);

  UnmodifiableMapView<String, dynamic> get movieDetail =>
      UnmodifiableMapView(_movieDetail);

  UnmodifiableListView<UnmodifiableMapView<String, dynamic>> get movieActors {
    List<UnmodifiableMapView<String, dynamic>> ret = [];
    _movieActors.forEach((element) => ret.add(UnmodifiableMapView(element)));
    return UnmodifiableListView(ret);
  }

  Future<void> fetchDetailMovie() async {
    String url =
        'https://api.themoviedb.org/3/movie/${movie.id.toString()}?language=ko-KR'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    _movieDetail = json.decode(response.body);
    notifyListeners();
  }

  Future<void> fetchMovieActor() async {
    String url = 'https://api.themoviedb.org/3/movie/${movie.id}/credits?'
        'api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    List<Map<String, dynamic>> _newActors = [];
    (responseMap['cast'] as List<dynamic>).forEach((dataMap) {
      if (dataMap != null && dataMap['profile_path'] != null)
        _newActors.add(dataMap as Map<String, dynamic>);
    });
    _movieActors = _newActors;
    notifyListeners();
  }
}
