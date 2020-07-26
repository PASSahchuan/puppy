import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Pag1 extends StatelessWidget {
  Pag1(bytes);
  Uint8List bytes;
  @override
  Widget build(BuildContext context) {
    print(bytes);
    return Container(
      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.memory(bytes),
            ],
          ),
        ],
      ),
    );
  }
}
