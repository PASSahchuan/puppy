import 'package:flutter/material.dart';
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
      routes: <String, WidgetBuilder>{'/TwoButtom': (_) => new TwobuttomPage()},
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
        child: Table(
          columnWidths: const <int, TableColumnWidth>{
            //指定索引及固定列宽
            0: FixedColumnWidth(30.0),
            1: FixedColumnWidth(120.0),
            2: FixedColumnWidth(110.0),
            3: FixedColumnWidth(30.0),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                Container(),
                Text('城市',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a))),
                DropdownTown(),
                Container(),
              ],
            ),
            TableRow(
              children: [
                Container(),
                Text('區',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a))),
                DropdownDistrict(),
                Container(),
              ],
            ),
            TableRow(
              children: [
                Container(),
                Text('里',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a))),
                DropdownVillage(),
                Container(),
              ],
            ),
            TableRow(
              children: [
                Container(),
                Text('調查天數',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a))),
                DropdownOfDay(),
                Container(),
              ],
            ),
          ],
        ),
        // RaisedButton(
        //   onPressed: imageUpload,
        // ),
      ),
    );
  }

  void imageUpload() {
    print('upload success!');
    Navigator.of(context).pushNamed('/TwoButtom');
  }
}
