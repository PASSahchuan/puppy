import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.db}) : super(key: key);
  final Database db;
  final String title = '狗狗調查大作戰';

  @override
  _LoginPageState createState() => _LoginPageState(db);
}

class _LoginPageState extends State<LoginPage> {
  _LoginPageState(this.db);
  Database db;
  TextEditingController _plan = TextEditingController();
  TextEditingController _user = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.deepOrange[300],
        ),
        body: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(40.0),
                padding: EdgeInsets.only(top: 80, bottom: 80),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextField(
                        controller: _plan,
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "計畫編號",
                          hintText: "計畫編號",
                          prefixIcon: Icon(Icons.person),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: _user,
                        autofocus: false,
                        decoration: InputDecoration(
                          labelText: "訪員編號",
                          hintText: "訪員編號",
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: RaisedButton(
                          child: Text('登錄'),
                          onPressed: login,
                          color: Color(0xfff18904),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void login() {
    print('ask login');

    if (true) //網路確認
    {
      set_user();
    }
  }

  void set_user() {
    db.execute("INSERT INTO USERE VALUES (1,'001','vddd');");
  }
}
