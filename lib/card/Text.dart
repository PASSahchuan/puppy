import 'package:flutter/material.dart';

Widget buildTextContainer() {
  var titleContainer = Text(
    'title',
    style: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
      fontSize: 14,
    ),
  );

  var descriptionContainer = Padding(
    padding: EdgeInsets.only(top: 8),
    child: Text(
      'title2',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  return Positioned(
    bottom: 60,
    left: 32,
    right: 32,
    child: Column(
      children: <Widget>[
        titleContainer,
        descriptionContainer,
      ],
    ),
  );
}
