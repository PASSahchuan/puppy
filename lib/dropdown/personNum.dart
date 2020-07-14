import 'package:flutter/material.dart';

class DropdownOfPerson extends StatefulWidget {
  DropdownOfPerson({Key key}) : super(key: key);

  @override
  _DropdownOfPersonState createState() => _DropdownOfPersonState();
}

class _DropdownOfPersonState extends State<DropdownOfPerson> {
  String dropdownValue = '001';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: TextStyle(color: Color(0xffD09E88)),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>[
        '001','+'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}
