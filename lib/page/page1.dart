import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Page1 extends StatefulWidget {
  Page1({Key key, this.bytes}) : super(key: key);
  var bytes;
  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.memory(base64Decode(widget.bytes)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("data"),
            ],
          ),
        ],
      ),
    );
  }
}
