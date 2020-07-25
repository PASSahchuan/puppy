import 'package:flutter/material.dart';
import 'package:puppy/test/Region_services.dart';

class DropdownDistrict extends StatefulWidget {
  DropdownDistrict(
      {Key key,
      @required this.callback,
      @required this.field,
      @required this.districtList})
      : super(key: key);
  Function(String, String) callback;
  String field;
  List<String> districtList;

  @override
  _DropdownDistrictState createState() => _DropdownDistrictState();
}

class _DropdownDistrictState extends State<DropdownDistrict> {
  String dropdownValue = '等待' /*'信義區'*/;
  List<String> districtList;
  List<String> villageList;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value:
          widget.districtList == null ? dropdownValue : widget.districtList[0],
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
          decodeRegion(dropdownValue);
          // widget.callback(widget.field, newValue);
        });
      },
      items: widget.districtList != null
          ? widget.districtList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 25),
                ),
              );
            }).toList()
          : ['等待'].map<DropdownMenuItem<String>>((String value) {
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
