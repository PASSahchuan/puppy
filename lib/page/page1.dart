import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Page1({this.b});
  Map<String, dynamic> b;
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.file(File(b['img'])),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            b['date'].substring(0, 10),
            style: TextStyle(color: Colors.white),
          ),
          Text(
            b['city'] + b['district'] + b['village'],
            style: TextStyle(color: Colors.white),
          ),
          Text(
            'lon: ${b["lon"]} lat: ${b["lat"]}',
            style: TextStyle(color: Colors.white),
          ),
        ],
      )
    ]);
  }
}
