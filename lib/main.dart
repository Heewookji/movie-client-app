import 'package:flutter/material.dart';
import 'package:movie_client_app/providers/movie_list_provider.dart';
import 'package:movie_client_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MovieListProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: _buildTheme(),
        home: HomeScreen(),
      ),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      canvasColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'NotoSansKR',
      textTheme: TextTheme(
        subtitle2: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        bodyText1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        bodyText2: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        caption: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
