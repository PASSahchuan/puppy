import 'package:flutter/material.dart';
import 'package:puppy/log_in/log_in.dart';
import 'dropdown/personNum.dart';
import 'card/card.dart';
import 'card/barTab.dart';
import 'card/newCard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: '狗狗調查大作戰'),
      // routes: <String, WidgetBuilder>{'/TwoButtom': (_) => new TwobuttomPage()},
      routes: <String, WidgetBuilder>{'/Login': (_) => new LoginPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Container(
        margin: EdgeInsets.all(25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          DropdownOfPerson(),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 30, bottom: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CardModel(),
                        SizedBox(width: 20,),
                        CardModel(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CardModel(),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xffDB6400),
                    child: Text('照片上傳'),
                    onPressed: upload,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  RaisedButton(
                    color: Color(0xffDB6400),
                    child: Text('拍攝照片'),
                    onPressed: takePicture,
                    textColor: Colors.white,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void upload() {
    print('upload success!');
  }

  void takePicture() {
    print('take picture success!');
  }
}
