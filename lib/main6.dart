import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:puppy/database/create_db.dart';
import 'package:puppy/main.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownTown.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownVillage.dart';
import 'dropdown/DropdownOfDay.dart';
import 'dropdown/DropdownOfNumDog.dart';
import 'dropdown/DropdownVillage.dart';
import 'test/Region_services.dart';
import 'package:http/http.dart' as http;

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title, @required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  File image;
  String _city = '台北市',
      _district = '松山區',
      _vilage = '東榮里',
      _dayCount = '0',
      _dogCount = '1',
      _repeatCount = '0';
  int id;
  bool ch_sw = false;
  @override
  Widget build(BuildContext context) {
    image = File(widget.image);
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
                child: Image.file(image),
              ),
              Container(
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    //指定索引及固定列宽
                    0: FixedColumnWidth(35.0),
                    1: FixedColumnWidth(100.0),
                    2: FixedColumnWidth(60.0),
                    3: FixedColumnWidth(125.0),
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
                          field: 'distinct',
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
                          callback: callback,
                          field: 'village',
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
        setState(() {});
        // print(_city);
        break;
      case 'district':
        _district = input;
        setState(() {});
        break;
      case "vilage":
        _vilage = input;
        setState(() {});
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

    showAlert(context, 0);
    var db = await db_get.create_db();
    var imageData = await db.rawQuery('SELECT MAX(id) FROM imagup');

    var user = await db
        .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
    print(
        '===================${imageData[0]['MAX(id)']}======================');
    if (imageData[0]['MAX(id)'] == null) {
      id = user[0]['id'] + 1;
    } else {
      id = imageData[0]['MAX(id)'] + 1;
    }

    var latlng = await Geolocator().getCurrentPosition();
    // db.rawQuery('SELECT MAX(datetime("date")) FROM USERE');
    var data = {
      "id": id,
      "plan": user[0]['plan'],
      "user": user[0]['user'],
      "img": base64Encode(image.readAsBytesSync()),
      "lat": latlng.latitude,
      "lon": latlng.longitude,
      "city": _city,
      "district": _district,
      "village": _vilage,
      'date': DateTime.now().toIso8601String(),
      "dayCount": _dayCount,
      'dogCount': _dogCount,
      'repeatCount': _repeatCount,
      'update_data': 0,
    };
    db.insert("imagup", data);
    db.update('imagup', {'img': widget.image},
        where:
            'id = $id AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}');

    var url = 'http://140.116.152.77:40129/img_upload';
    http.Response response;
    try {
      print("object");
      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: 15),
            onTimeout: () => null,
          );
    } catch (_) {
      response = null;
    }
    Navigator.pop(context); //離開Alert
    if (response != null) //網路確認
    {
      var getJson = jsonDecode(response.body);
      if (getJson['success']) {
        db.update('imagup', {'update_data': 1},
            where:
                'id = $id AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}');
        await showAlert(context, 1);
      } else {
        await showAlert(context, 3);
      }
    } else {
      await showAlert(context, 2);
    }
    ch_sw = false;
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) {
      return MyHomePage(title: '狗狗調查大作戰');
    }), (route) => false);
  }

  void login() {
    print('login success!');
    Navigator.of(context).pushNamed('/Login');
  }

  void questionnaireSendOut() {
    print('Questionnaire send out success!');
    Navigator.pop(context);
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
                child: Text("上傳中..."),
              )
            ],
          ),
        );
        break;
      case 1:
        return AlertDialog(
          title: Text('上傳成功'),
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
          title: Text('資料庫失敗'),
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
