import 'package:flutter/material.dart';
import 'package:puppy/log_in/log_in.dart';
import 'main_widget/DropdownTown.dart';
import 'main_widget/DropdownDistrict.dart';
import 'main_widget/DropdownVillage.dart';
import 'main_widget/DropdownOfDay.dart';
import 'choose_widget/Two_Button.dart';

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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Image.asset('assets/mainDog.jpg'),
          ),
          Container(
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                //指定索引及固定列宽
                0: FixedColumnWidth(35.0),
                1: FixedColumnWidth(100.0),
                2: FixedColumnWidth(30.0),
                3: FixedColumnWidth(110.0),
                4: FixedColumnWidth(35.0),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    Container(),
                    Text(
                      '城市',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    Container(),
                    DropdownTown(),
                    Container(),
                  ],
                ),
                TableRow(
                  children: [
                    Container(),
                    Text(
                      '區',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    Container(),
                    DropdownDistrict(),
                    Container(),
                  ],
                ),
                TableRow(
                  children: [
                    Container(),
                    Text(
                      '里',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    Container(),
                    DropdownVillage(),
                    Container(),
                  ],
                ),
                TableRow(
                  children: [
                    Container(),
                    Text(
                      '調查天數',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    Container(),
                    DropdownOfDay(),
                    Container(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('開始拍照'),
              onPressed: imageUpload,
              color: Colors.deepOrangeAccent[300],
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text('登入'),
              onPressed: login,
              color: Colors.deepOrangeAccent[300],
            ),
          )
        ],
      )),
    );
  }

  void imageUpload() {
    print('upload success!');
    Navigator.of(context).pushNamed('/TwoButtom');
  }

  void login() {
    print('login success!');
    Navigator.of(context).pushNamed('/Login');
  }
}
