import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  Page1({this.b});
  String b;
  @override
  Widget build(BuildContext context) {
    return Image.file(File(b));
  }
}
