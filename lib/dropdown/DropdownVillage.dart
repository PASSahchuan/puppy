import 'package:flutter/material.dart';
import 'package:puppy/test/Region_services.dart';
import 'package:puppy/test/stupid.dart';

class DropdownVillage extends StatefulWidget {
  DropdownVillage({
    Key key,
    @required this.callback,
    @required this.field,
  }) : super(key: key);
  Function(String, String) callback;
  String field;

  @override
  _DropdownVillageState createState() => _DropdownVillageState();
}

String village_record = villageList[0];

class _DropdownVillageState extends State<DropdownVillage> {
  String dropdownValue = village_record;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    if ((distinctChange == true) || (cityChange == true)) {
      // print('object');
      // print(villageList[0]);
      dropdownValue = villageList[0];
      distinctChange = false;
      cityChange = false;
    } else {
      dropdownValue = village_record;
    }
    // print('object');
    // print(dropdownValue);
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: TextStyle(color: Color(0xffD09E88)),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) {
        //change village
        dropdownValue = newValue;
        village_record = newValue;
        //callback
        widget.callback('vilage', newValue);
      },

      items: villageList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 25),
            ),
        );
      }).toList(),
      // items: widget.villageList != null
      //     ? widget.villageList.map<DropdownMenuItem<String>>((String value) {
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
