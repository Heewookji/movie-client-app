import 'package:flutter/material.dart';
import 'package:movie_client_app/models/movie_dto.dart';

class DetailScreen extends StatelessWidget {
  final MovieDto movie;

  DetailScreen(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(movie.title),
    );
  }
}
