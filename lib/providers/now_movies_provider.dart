import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:movie_client_app/keys.dart';
import 'package:movie_client_app/models/movie_dto.dart';
import 'package:movie_client_app/models/serializers.dart';

class NowMoviesProvider extends ChangeNotifier {
  int _page = 0;
  List<MovieDto> _nowMovies = [];

  UnmodifiableListView<MovieDto> get nowMovies =>
      UnmodifiableListView(_nowMovies);

  Future<void> fetchAndSetNowMovies() async {
    String url = 'https://api.themoviedb.org/3/discover/movie?'
        'primary_release_date.lte=${DateFormat('yyyy-MM-dd').format(DateTime.now())}'
        '&api_key=${Keys.apiKey}';
    final response = await http.get(url);
    Map<String, dynamic> responseMap = json.decode(response.body);
    _page = responseMap['page'];
    _nowMovies = (responseMap['results'] as List<dynamic>).map((dataMap) {
      return serializers.deserializeWith(MovieDto.serializer, dataMap);
    }).toList();
  }
}
