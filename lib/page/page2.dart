import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  Page2({Key key, this.b}) : super(key: key);
  String b;
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Container(
      color: Colors.red,
      child: Column(
        children: <Widget>[
          //Image.file(File(widget.b)),
          Text(widget.b),
        ],
      ),
    );
  }
}
