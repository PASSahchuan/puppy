import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  final String title = '狗狗調查大作戰';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Container(
        margin: EdgeInsets.all(40.0), 
        padding: EdgeInsets.only(top: 80, bottom: 80),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "計畫編號",
                  hintText: "計畫編號",
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "訪員編號",
                  hintText: "訪員編號",
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              RaisedButton(child: Text('登錄'), onPressed: login),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    print('ask login');
  }
}
