import 'package:flutter/material.dart';
import 'package:puppy/dropdown/DropdownTown.dart';
import 'package:puppy/dropdown/DropdownVillage.dart';
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

String district_record = distinctLists[0];

class _DropdownDistrictState extends State<DropdownDistrict> {
  String dropdownValue = district_record; /*'信義區'*/

  @override
  Widget build(BuildContext context) {
    if (cityChange == true) {
      dropdownValue = distinctLists[0];
      cityChange = false;
      distinctChange = true;
      villageList = getVillage(city_record,dropdownValue);
      // widget.callback('district', dropdownValue);
      // widget.callback('vilage', villageList[0]);
    } else {
      dropdownValue = district_record;
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
        //change dist
        dropdownValue = newValue;
        district_record = newValue;
        //change village
        villageList = getVillage(city_record,dropdownValue);
        village_record = villageList[0];
        //callback
        widget.callback('district', newValue);
        widget.callback('vilage', villageList[0]);
        cityChange = false;
        distinctChange = true;
      },
      items: distinctLists.map<DropdownMenuItem<String>>((String value) {
        // print('value');
        // print(value);
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 25),
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
