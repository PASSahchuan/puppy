import 'package:flutter/material.dart';

class DropdownDistrict extends StatefulWidget {
  DropdownDistrict({Key key}) : super(key: key);

  @override
  _DropdownDistrictState createState() => _DropdownDistrictState();
}

class _DropdownDistrictState extends State<DropdownDistrict> {
  String dropdownValue = '信義區';
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: TextStyle(color: Color(0xffD09E88),),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['北投區', '士林區', '內湖區', '松山區', '中山區', '大同區', '萬華區', '中正區', '大安區', '信義區', '南港區', '文山區']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: TextStyle(fontSize: 25),),
        );
      }).toList(),
    );
  }
}