import 'package:flutter/material.dart';
import 'package:puppy/main.dart';
import 'package:puppy/main6.dart';

class DropdownTown extends StatefulWidget {
  DropdownTown({Key key, @required this.callback}) : super(key: key);
  Function(String, String) callback;
  @override
  _DropdownTownState createState() => _DropdownTownState();
}

class _DropdownTownState extends State<DropdownTown> {
  String dropdownValue = '台北市';
  @override
  Widget build(BuildContext context) {
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

          print(newValue);
        });
        widget.callback('city', newValue);
      },
      items: <String>[
        '基隆市',
        '台北市',
        '新北市',
        '桃園縣',
        '新竹市',
        '新竹縣',
        '苗栗縣',
        '台中市',
        '彰化縣',
        '南投縣',
        '雲林縣',
        '嘉義市',
        '嘉義縣',
        '台南市',
        '高雄市',
        '屏東縣',
        '台東縣',
        '花蓮縣',
        '宜蘭縣',
        '澎湖縣',
        '金門縣',
        '連江縣'
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
