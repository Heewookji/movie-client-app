import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            '현재 상영중',
            style: theme.textTheme.subtitle2,
          ),
        ),
      ),
    );
  }
}
