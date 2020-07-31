import 'package:flutter/material.dart';
import 'package:puppy/database/create_db.dart';
import 'package:puppy/log_in/log_in.dart';

class DropdownOfPerson extends StatelessWidget {
  DropdownOfPerson(
      {@required this.user_data,
      @required this.dropdownValue,
      @required this.callback});
  List<String> user_data = List<String>();
  String dropdownValue = '+';
  Function callback;
  @override
  Widget build(BuildContext context) {
    user_data.add('+');
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: TextStyle(color: Color(0xffD09E88)),
      underline: Container(
        height: 2,
        color: Color(0xffD09E88),
      ),
      onChanged: (String newValue) async {
        var db = await await db_get.create_db();
        if (newValue == '+') {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return LoginPage(db: db);
          }));
        } else {
          var data_str = newValue.split('\\');
          print(data_str);
          var db = await await db_get.create_db();
          db.execute(
              'UPDATE USERE SET date = datetime("now") WHERE plan=${data_str[0]} AND user=${data_str[1]};');
          print(await db.query('USERE'));
          callback();
        }
      },
      items: user_data.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        );
      }).toList(),
    );
  }
}
