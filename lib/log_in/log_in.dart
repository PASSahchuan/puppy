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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "計畫編號",
                hintText: "計畫編號",
                prefixIcon: Icon(Icons.person),
              ),
            ),
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: "訪員編號",
                hintText: "訪員編號",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
