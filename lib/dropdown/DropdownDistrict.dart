import 'package:flutter/material.dart';

class DropdownDistrict extends StatefulWidget {
  DropdownDistrict(
      {Key key,
      @required this.callback,
      @required this.field,
      @required this.districtList})
      : super(key: key);
  Function(String, String) callback;
  String field;
  Future<List<dynamic>> districtList;

  @override
  _DropdownDistrictState createState() => _DropdownDistrictState();
}

class _DropdownDistrictState extends State<DropdownDistrict> {
  String dropdownValue = '0' /*'信義區'*/;
  List<dynamic> districtList;

  @override
  Widget build(BuildContext context) {
    () async {
      districtList = await widget.districtList;
      setState(() {});
    };
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
          widget.callback(widget.field, newValue);
        });
      },
      items: <String>[
        '0',
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
      ] /*districtList*/ .map<DropdownMenuItem<String>>((String value) {
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
