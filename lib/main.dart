import 'package:flutter/material.dart';
import 'package:movie_client_app/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: HomeScreen(),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      canvasColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        subtitle2: TextStyle(
          fontSize: 20,
          height: 29,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          height: 23,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          height: 20,
          fontWeight: FontWeight.normal,
        ),
        caption: TextStyle(
          fontSize: 9,
          height: 13,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
