import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:movie_client_app/keys.dart';
import 'package:movie_client_app/models/movie_dto.dart';
import 'package:movie_client_app/models/serializers.dart';

class HomeMoviesProvider extends ChangeNotifier {
  int _nowMoviePage = 0;
  List<MovieDto> _nowMovies = [];
  List<MovieDto> _notYetMovies = [];
  List<MovieDto> _popularMovies = [];
  List<MovieDto> _highRateMovies = [];
  Map<int, String> _genres = {};

  UnmodifiableListView<MovieDto> get nowMovies =>
      UnmodifiableListView(_nowMovies);

  UnmodifiableListView<MovieDto> get notYetMovies =>
      UnmodifiableListView(_notYetMovies);

  UnmodifiableListView<MovieDto> get popularMovies =>
      UnmodifiableListView(_popularMovies);

  UnmodifiableListView<MovieDto> get highRateMovies =>
      UnmodifiableListView(_highRateMovies);

  UnmodifiableMapView<int, String> get genres => UnmodifiableMapView(_genres);

  Future<void> fetchAndSetGenres() async {
    String url = 'https://api.themoviedb.org/3/genre/movie/list?'
        'api_key=${Keys.apiKey}&language=en-US';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    Map<int, String> newMap = {};
    (responseMap['genres'] as List<dynamic>).forEach((dataMap) {
      newMap[dataMap['id']] = dataMap['name'];
    });
    _genres = newMap;
  }

  Future<void> fetchNextNowMoviePage() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'primary_release_date.gte=${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 30)))}'
        '&primary_release_date.lte=${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
        '&api_key=${Keys.apiKey}&page=${_nowMoviePage + 1}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _nowMoviePage = responseMap['page'];
    _nowMovies.addAll((responseMap['results'] as List<dynamic>)
        .map((dataMap) =>
            serializers.deserializeWith(MovieDto.serializer, dataMap))
        .toList());
    notifyListeners();
  }

  Future<void> fetchAndSetNowMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'primary_release_date.gte=${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 30)))}'
        '&primary_release_date.lte=${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _nowMoviePage = responseMap['page'];
    _nowMovies = (responseMap['results'] as List<dynamic>)
        .map((dataMap) =>
            serializers.deserializeWith(MovieDto.serializer, dataMap))
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetNotYetMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'primary_release_date.gte=${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)))}'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _notYetMovies = (responseMap['results'] as List<dynamic>)
        .map((dataMap) =>
            serializers.deserializeWith(MovieDto.serializer, dataMap))
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetPopularMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'sort_by=popularity.desc'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _popularMovies = (responseMap['results'] as List<dynamic>)
        .map((dataMap) =>
            serializers.deserializeWith(MovieDto.serializer, dataMap))
        .toList();
    notifyListeners();
  }

  Future<void> fetchAndSetHighRateMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'certification_country=US&certification=R&sort_by=vote_average.desc'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _highRateMovies = (responseMap['results'] as List<dynamic>)
        .map((dataMap) =>
            serializers.deserializeWith(MovieDto.serializer, dataMap))
        .toList();
    notifyListeners();
  }
}
