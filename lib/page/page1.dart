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
        children: <Widget>[
          Text(b['date'].substring(0, 10)),
          Text(b['city'] + b['district'] + b['village']),
          Text('lon: ${b["lon"]} lat: ${b["lat"]}'),
        ],
      )
    ]);
  }
}
