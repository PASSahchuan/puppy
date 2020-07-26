import 'package:flutter/material.dart';
import 'package:puppy/main.dart';
import 'package:puppy/main6.dart';
import 'package:puppy/test/stupid.dart';

import '../test/stupid.dart';

class DropdownTown extends StatefulWidget {
  DropdownTown(
    {Key key, 
    @required this.callback, 
    @required this.field})
      : super(key: key);
  Function(String, String) callback;
  String field;
  @override
  _DropdownTownState createState() => _DropdownTownState();
}

class _DropdownTownState extends State<DropdownTown> {
  String dropdownValue = '台北市';
  List<String> districtList;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: TextStyle(
        color: Color(0xffD09E88),
      ),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;

          print(newValue);
        });
        widget.callback(widget.field, newValue);
      },
      items: cityList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 25),
          ),
        );
      }).toList(),
    );
  }
}
