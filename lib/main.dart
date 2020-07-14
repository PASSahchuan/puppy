import 'package:flutter/material.dart';
import 'package:puppy/log_in/log_in.dart';
import 'dropdown/personNum.dart';
import 'card/card.dart';

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
                  Container(
                    child: Table(
                      columnWidths: const <int, TableColumnWidth>{
                        //指定索引及固定列宽
                        0: FixedColumnWidth(60.0),
                        1: FixedColumnWidth(210.0),
                        2: FixedColumnWidth(60.0),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(
                          children: [
                            DropdownOfPerson(),
                            Container(),
                            Container(),
                          ],
                        ),
                        TableRow(
                          children: [
                            CardModel(),
                            CardModel(),
                            CardModel(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text('照片上傳！'),
                    onPressed: upload,
                    textColor: Colors.deepOrangeAccent,
                  ),
                  RaisedButton(
                    child: Text('拍攝照片！'),
                    onPressed: takePicture,
                    textColor: Colors.deepOrangeAccent,
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
