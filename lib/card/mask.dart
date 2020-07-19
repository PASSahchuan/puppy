import 'package:flutter/material.dart';

var imageOverlayGradient = DecoratedBox(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: FractionalOffset.topCenter,
      end: FractionalOffset.bottomCenter,
      colors: [
        Color.fromRGBO(0, 0, 0, 0),
        Color.fromRGBO(0, 0, 0, 0.8),
      ]
    ),
  ),
);