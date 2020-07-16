import 'package:flutter/material.dart';

class DropdownOfNumDog extends StatefulWidget {
  DropdownOfNumDog({Key key}) : super(key: key);

  @override
  _DropdownOfNumDogState createState() => _DropdownOfNumDogState();
}

class _DropdownOfNumDogState extends State<DropdownOfNumDog> {
  String dropdownValue = '1';
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
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '10',
        '11',
        '12',
        '13',
        '14',
        '15',
        '16',
        '17'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}