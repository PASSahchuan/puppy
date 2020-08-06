import 'package:flutter/material.dart';
import 'package:puppy/test/stupid.dart';
import 'DropdownDistrict.dart';
import 'DropdownVillage.dart';
import '../test/stupid.dart';

class DropdownTown extends StatefulWidget {
  DropdownTown({Key key, @required this.callback, @required this.field})
      : super(key: key);
  Function(String, String) callback;
  String field;
  @override
  _DropdownTownState createState() => _DropdownTownState();
}

String city_record = cityList[0];

class _DropdownTownState extends State<DropdownTown> {
  String dropdownValue = city_record;
  String tmpVillage;
  @override
  Widget build(BuildContext context) {
    dropdownValue = city_record;
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
        //change town
        dropdownValue = newValue;
        city_record = newValue;
        //change dist
        distinctLists = judge(dropdownValue);
        district_record = distinctLists[0];
        //change village
        tmpVillage = getVillage(dropdownValue,distinctLists[0])[0];
        village_record = tmpVillage;
        //callback
        widget.callback(widget.field, newValue);
        widget.callback('district', distinctLists[0]);
        widget.callback('vilage', tmpVillage);
        cityChange = true;
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
