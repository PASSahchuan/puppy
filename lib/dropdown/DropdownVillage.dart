import 'package:flutter/material.dart';
import 'package:puppy/test/Region_services.dart';

class DropdownVillage extends StatefulWidget {
  DropdownVillage(
      {Key key,
      @required this.callback,
      @required this.field,
      @required this.villageList})
      : super(key: key);
  Function(String, String) callback;
  String field;
  List<String> villageList;

  @override
  _DropdownVillageState createState() => _DropdownVillageState();
}

class _DropdownVillageState extends State<DropdownVillage> {
  String dropdownValue = '等待';
  List<String> villageList;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value:
          widget.villageList == null ? dropdownValue : widget.villageList[0],
      elevation: 16,
      style: TextStyle(color: Color(0xffD09E88)),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          decodevillage(dropdownValue);
          // widget.callback(widget.field, newValue);
        });
      },
      items: widget.villageList != null
          ? widget.villageList.map<DropdownMenuItem<String>>((String value) {
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
