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

  void login() async {
    print('ask login');
    showAlert(context, 0);
    await Future.delayed(Duration(seconds: 3), () {
      //到時回撥
      return 1;
    });
    Navigator.pop(context);
    showAlert(context, 1);
    if (true) //網路確認
    {
      set_user();
    }
  }

  void set_user() {
    // db.execute("INSERT INTO USERE VALUES (1,'001','vddd');");
  }
  Future<void> showAlert(BuildContext context, int t) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, //點旁邊不關閉
      builder: (context) {
        return alertLoad(t);
      },
    );
  }

  Widget alertLoad(var t) {
    switch (t) {
      case 0:
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("登入中..."),
              )
            ],
          ),
        );
        break;
      case 1:
        return AlertDialog(
          title: Text('登入成功'),
          actions: <Widget>[
            FlatButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
        break;
      default:
    }
  }
}
