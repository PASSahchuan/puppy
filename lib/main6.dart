import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gps/gps.dart';
import 'package:puppy/database/create_db.dart';
import 'dropdown/DropdownTown.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownVillage.dart';
import 'dropdown/DropdownOfDay.dart';
import 'dropdown/DropdownOfNumDog.dart';
import 'test/Region_services.dart';
import 'test/Region_services.dart';

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title, @required this.image}) : super(key: key);

  final String title;
  final Uint8List image;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  String _city = '台北市', _district = '松山區', _vilage = '東榮里', _dayCount = '0', _dogCount = '1', _repeatCount = '0';
  int id;
  bool ch_sw = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          // width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(25),
          alignment: Alignment.center,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                child: Image.memory(widget.image),
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
                        DropdownTown(
                          callback: callback,
                          field: 'city',
                        ),
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
                        DropdownDistrict(
                          callback: callback,
                          field: 'district',
                          districtList: decodeRegion(_city),
                        ),
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
                        DropdownVillage(
                          callback: this.callback,
                          field: 'vilage',
                        ),
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
                        DropdownOfDay(
                          callback: this.callback,
                          field: 'dayCount',
                        ),
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
                    DropdownOfNumDog(
                      callback: this.callback,
                      field: 'dogCount',
                    ),
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
                    DropdownOfNumDog(
                      callback: this.callback,
                      field: 'repeatCount',
                    ),
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
                      onPressed: imageUpload,
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
        // print(_city);
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
    setState(() {});
  }

  void imageUpload() async {
    if (ch_sw) return;
    ch_sw = true;
    var db = await db_get.create_db();
    var imageData = await db.rawQuery('SELECT MAX(id) FROM imagup');

    if (imageData[0]['MAX(id)'] == null) {
      id = 1;
    } else {
      id = imageData[0]['MAX(id)'] + 1;
    }
    var latlng = await Gps.currentGps();
    // db.rawQuery('SELECT MAX(datetime("date")) FROM USERE');
    print(await db.rawQuery('SELECT MAX(datetime("date")) FROM USERE'));

    print(latlng.lat);
    print(latlng.lng);
    ch_sw = false;
  }

  void login() {
    print('login success!');
    Navigator.of(context).pushNamed('/Login');
  }

  void questionnaireSendOut() {
    print('Questionnaire send out success!');
    decodeRegion(_city);
    Navigator.pop(context);
  }
}
