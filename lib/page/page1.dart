import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Pag1 extends StatelessWidget {
  Pag1(b);
  Uint8List b;
  @override
  Widget build(BuildContext context) {
    print(b);
    return Container(
      color: Colors.blue,
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.memory(b),
            ],
          ),
        ],
      ),
    );
  }
}
