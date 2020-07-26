import 'package:flutter/material.dart';
import 'package:puppy/test/stupid.dart';

class DropdownDistrict extends StatefulWidget {
  DropdownDistrict({
    Key key,
    @required this.callback,
    @required this.field,
  }) : super(key: key);
  Function(String, String) callback;
  String field;

  @override
  _DropdownDistrictState createState() => _DropdownDistrictState();
}

class _DropdownDistrictState extends State<DropdownDistrict> {
  String dropdownValue = distinctLists[0] /*'信義區'*/;

  @override
  Widget build(BuildContext context) {
    if (cityChange == true) {
      dropdownValue = distinctLists[0];
      cityChange = false;
      distinctChange = true;
      villageList = getVillage(dropdownValue);
    }

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
        dropdownValue = newValue;
        cityChange = false;
        distinctChange = true;
        setState(() {
          villageList = getVillage(newValue);
          // print('dropdownValue');
          // print(dropdownValue);
          // print('newValue');
          // print(newValue);
          // print('object');
          print(villageList);
          // // decodeRegion(dropdownValue);
          widget.callback(widget.field, newValue);
        });
      },
      items: distinctLists.map<DropdownMenuItem<String>>((String value) {
        print('value');
        print(value);
        return DropdownMenuItem<String>(
          value: value,
          child: Center(
            child: Text(
              value,
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }).toList(),
      // items: widget.districtList != null
      //     ? widget.districtList.map<DropdownMenuItem<String>>((String value) {
      //         return DropdownMenuItem<String>(
      //           value: value,
      //           child: Text(
      //             value,
      //             style: TextStyle(fontSize: 25),
      //           ),
      //         );
      //       }).toList()
      //     : ['等待'].map<DropdownMenuItem<String>>((String value) {
      //         return DropdownMenuItem<String>(
      //           value: value,
      //           child: Text(
      //             value,
      //             style: TextStyle(fontSize: 25),
      //           ),
      //         );
      //       }).toList(),
    );
  }
}
