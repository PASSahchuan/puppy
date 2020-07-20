import 'package:flutter/material.dart';
import 'package:puppy/size_config.dart';

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
          child: Container(
              // width: SizeConfig.defaultSize*1.6,
              // height: SizeConfig.defaultSize*2.5,
              alignment: Alignment.center,
              child: Row(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 30,),
                      Image.asset(
                        'assets/mainDog.jpg',
                        width: 125,
                      ),
                      SizedBox(height: 70,),
                      Text(
                        "image" + dropdownValue,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ))),
    );
  }
}
