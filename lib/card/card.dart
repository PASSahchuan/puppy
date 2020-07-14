import 'package:flutter/material.dart';

class CardModel extends StatefulWidget {
  CardModel({Key key}) : super(key: key);

  @override
  _CardModelState createState() => _CardModelState();
}

class _CardModelState extends State<CardModel> {
  String dropdownValue = '信義區';
  int value;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Card(
          color: Color(0xfffbd14b),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          // 抗鋸齒
          clipBehavior: Clip.antiAlias,
          elevation: 20, // 陰影大小
          child: new Container(
            width: 160,
            height: 250,
            alignment: Alignment.center,
            child: new Text(
              "image" + value.toString(),
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
