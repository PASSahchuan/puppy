import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Page1({this.b});
  Map<String, dynamic> b;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(children: <Widget>[
        Image.file(File(b['img'])),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              b['date'].substring(0, 10),
              style: TextStyle(
                  color: Color.fromARGB((0.8 * 255).toInt(), 139, 69, 19)),
            ),
            Text(b['city'] + b['district'] + b['village'],
                style: TextStyle(
                    color: Color.fromARGB((0.8 * 255).toInt(), 139, 69, 19))),
            Text(
              'lon: ${b["lon"]}\nlat: ${b["lat"]}',
              style: TextStyle(
                  color: Color.fromARGB((0.8 * 255).toInt(), 139, 69, 19)),
            ),
          ],
        )
      ]),
    );
  }
}
