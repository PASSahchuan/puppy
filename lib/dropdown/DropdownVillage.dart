import 'package:flutter/material.dart';

class DropdownVillage extends StatefulWidget {
  DropdownVillage({Key key, @required this.callback, @required this.field})
      : super(key: key);
  Function(String, String) callback;
  String field;
  @override
  _DropdownVillageState createState() => _DropdownVillageState();
}

class _DropdownVillageState extends State<DropdownVillage> {
  String dropdownValue = '中南里';
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
          widget.callback(widget.field, newValue);
        });
      },
      items: <String>[
        '中南里',
        '新富里',
        '南港里',
        '三重里',
        '西新里',
        '東明里',
        '東新里',
        '新光里',
        '重陽里',
        '成福里',
        '百福里',
        '聯成里',
        '玉成里',
        '鴻福里',
        '萬福里',
        '合成里',
        '仁福里'
      ].map<DropdownMenuItem<String>>((String value) {
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
