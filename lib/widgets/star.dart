import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Star extends StatelessWidget {
  final double value;

  Star(this.value);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: value / 2,
      allowHalfRating: true,
      ignoreGestures: true,
      itemSize: 12,
      itemPadding: EdgeInsets.only(right: 4),
      itemBuilder: (ctx, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      unratedColor: Colors.black26,
      onRatingUpdate: null,
    );
  }
}
