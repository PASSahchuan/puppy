import 'package:flutter/material.dart';

class DropdownOfPerson extends StatelessWidget {
  // DropdownOfPerson({@required this.user_data,@required this.dropdownValue});
  List<String> user_data = List<String>();
  String dropdownValue = '';
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
        dropdownValue = newValue;
      },
      items: user_data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 22),
          ),
        );
      }).toList(),
    );
  }
}
