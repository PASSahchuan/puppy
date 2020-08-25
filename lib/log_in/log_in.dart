import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key, @required this.db}) : super(key: key);
  final Database db;
  final String title = '遊蕩犬調查';

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
    showAlert(context, 0);
    var data = {'plan': _plan.text, 'user': _user.text};
    var url =
        'http://140.116.152.77:40129/authUser'; //http://140.116.152.77:40129/authUser
    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: 2),
            onTimeout: () => null,
          );
    } catch (_) {
      response = null;
    }
    Navigator.pop(context); //離開Alert
    print('登入： $response');
    if (response != null) //網路確認
    {
      var temp_json_data = jsonDecode(response.body);
      if (temp_json_data['success']) {
        if (temp_json_data['id'] == null) {
          await showAlert(context, 4);
          return null;
        }
        print(
            '登入頁===================${temp_json_data['id']}======================');
        set_user(_plan.text, _user.text, temp_json_data['id'],
            temp_json_data['name']);
        user_name = temp_json_data['name'];

        await showAlert(context, 1);
      } else {
        await showAlert(context, 3);
      }
    } else {
      await showAlert(context, 2);
    }
  }

  void set_user(String plan, String user, int id, String name) async {
    var user_data_is_in =
        await db.query('USERE', where: "plan = '$plan' AND user = '$user'");
    if (user_data_is_in == null || user_data_is_in.isEmpty) {
      db.execute(
          "INSERT INTO USERE VALUES ( '$plan' , '$user' , '$name', '$id' ,datetime('now'));");
    } else {
      db.update("USERE", {'date': 'datetime("now"))', 'id': '$id'},
          where: "plan = '$plan' AND user = '$user'");
    }
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return MyApp();
                }), (route) => false);
              },
            ),
          ],
        );
        break;
      case 2:
        return AlertDialog(
          title: Text('與伺服器連線失敗'),
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
      case 3:
        return AlertDialog(
          title: Text('帳密失敗'),
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
      case 4:
        return AlertDialog(
          title: Text('id 失敗請洽伺服器'),
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
