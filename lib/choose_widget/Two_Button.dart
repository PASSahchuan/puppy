import 'dart:ffi';

import 'package:flutter/material.dart';
import '../choose_widget/button.dart';

class TwobuttomPage extends StatefulWidget {
  TwobuttomPage({Key key}) : super(key: key);

  final String title = '狗狗調查大作戰';

  @override
  _TwobuttomPageState createState() => _TwobuttomPageState();
}

class _TwobuttomPageState extends State<TwobuttomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomButton(onPressed: () {  },),
          ],
        ),
      ),
    );
  }
   void imageUpload(){
      print('upload success!');
    }
    void tap(){
      print('tap success!');
    }
}