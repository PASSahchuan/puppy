import 'package:flutter/material.dart';
import 'package:puppy/log_in/log_in.dart';
import 'dropdown/DropdownTown.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownVillage.dart';
import 'dropdown/DropdownOfDay.dart';
import 'dropdown/DropdownOfNumDog.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage2(title: '狗狗調查大作戰'),
      // routes: <String, WidgetBuilder>{'/TwoButtom': (_) => new TwobuttomPage()},
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String _city, _district, _vilage, _dayCount, _dogCount, _repeatCount;
  @override
  Widget build(BuildContext context) {
    print(_city);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(25),
          alignment: Alignment.center,
          child: Center(
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
                    2: FixedColumnWidth(60.0),
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
                          style:
                              TextStyle(fontSize: 23, color: Color(0xff52616a)),
                          textAlign: TextAlign.start,
                        ),
                        Container(),
                        DropdownTown(callback: callback),
                        Container(),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(),
                        Text(
                          '鄉鎮市區',
                          style:
                              TextStyle(fontSize: 23, color: Color(0xff52616a)),
                          textAlign: TextAlign.start,
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
                          '村里',
                          style:
                              TextStyle(fontSize: 23, color: Color(0xff52616a)),
                          textAlign: TextAlign.start,
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
                          style:
                              TextStyle(fontSize: 23, color: Color(0xff52616a)),
                          textAlign: TextAlign.start,
                        ),
                        Container(),
                        DropdownOfDay(),
                        Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.blueGrey,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      '照片中有幾隻狗',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    DropdownOfNumDog(),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      '照片中的狗有幾隻與之前重複',
                      style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                      textAlign: TextAlign.center,
                    ),
                    DropdownOfNumDog(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      child: Text('捨棄'),
                      onPressed: questionnaireSendOut,
                      color: Color(0xfff18904),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Container(
                    child: RaisedButton(
                      child: Text('送出'),
                      onPressed: questionnaireSendOut,
                      color: Color(0xfff18904),
                    ),
                  ),
                ],
              ),
              // Container(
              //   child: RaisedButton(
              //     child: Text('登入'),
              //     onPressed: login,
              //     color: Color(0xfff18904),
              //   ),
              // ),
            ],
          )),
        ),
      ),
    );
  }

  void callback(String count, String input) {
    //_city,_district,_vilage,_dayCount,_dogCount,_repeatCount;

    switch (count) {
      case 'city':
        _city = input;
        break;
      case 'district':
        _district = input;
        break;
      case "vilage":
        _vilage = input;
        break;
      case "dayCount":
        _dayCount = input;
        break;
      case 'dogCount':
        _dogCount = input;
        break;
      case 'repeatCount':
        _repeatCount = input;
        break;
      default:
    }
    // setState(() {});
  }

  void imageUpload() {}

  void login() {
    print('login success!');
    Navigator.of(context).pushNamed('/Login');
  }

  void questionnaireSendOut() {
    print('Questionnaire send out success!');
    setState(() {});
  }
}
