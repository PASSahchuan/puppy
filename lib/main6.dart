import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:puppy/database/create_db.dart';
import 'package:puppy/main.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownTown.dart';
import 'dropdown/DropdownVillage.dart';
import 'dropdown/DropdownOfDay.dart';
import 'dropdown/DropdownOfNumDog.dart';
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
  String _city = null,
      _district = null,
      _vilage = null,
      _dayCount = '0',
      _dogCount = '1',
      _repeatCount = '0';
  int id;
  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    DateTime today = new DateTime.now();
    String dateSlug =
        "${today.year.toString()}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    image = File(widget.image);
    print(_city);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.deepOrange[300],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Object>(
            future: get_lon(),
            builder: (context, snapshot) {
              print("--------------");
              if (snapshot.data != null && _city == null) {
                print(snapshot.data);
                var data = jsonDecode(snapshot.data);
                print("--------------");
                _city = data['city'];
                _district = data['suburb'];
                _vilage = data['city_district'];
                print(_city);
              }
              print("object61");
              print(_city);
              if (_city == null) {
                _city = city_record;
                _district = district_record;
                _vilage = village_record;
                print("object66");
              }
              print("object67");
              // _city=data['cit'];
              return Container(
                // height: MediaQuery.of(context).size.height,
                // width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(25),
                alignment: Alignment.center,
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Stack(children: <Widget>[
                      Container(
                        child: Image.file(image),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dateSlug,
                            style: TextStyle(
                                color: Color.fromARGB(
                                    (0.8 * 255).toInt(), 139, 69, 19)),
                          ),
                          Text(
                            _city + _district + _vilage,
                            style: TextStyle(
                                color: Color.fromARGB(
                                    (0.8 * 255).toInt(), 139, 69, 19)),
                          ),
                          FutureBuilder(
                              future: Geolocator().getCurrentPosition(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                    'lon: ${snapshot.data.longitude} lat: ${snapshot.data.latitude} ',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            (0.8 * 255).toInt(), 139, 69, 19)),
                                  );
                                } else {
                                  return Text(
                                    'lon: error lat: error ',
                                    style: TextStyle(
                                        color: Color.fromARGB(
                                            (0.8 * 255).toInt(), 139, 69, 19)),
                                  );
                                }
                              })
                        ],
                      ),
                    ]),
                    Container(
                      child: Table(
                        columnWidths: <int, TableColumnWidth>{
                          //指定索引及固定列宽
                          0: FixedColumnWidth(screen.width / 320.0 * 25.0),
                          1: FixedColumnWidth(screen.width / 320.0 * 80.0),
                          2: FixedColumnWidth(screen.width / 320.0 * 55.0),
                          3: FixedColumnWidth(screen.width / 320.0 * 103.0),
                          4: FixedColumnWidth(screen.width / 320.0 * 50.0),
                        },
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          TableRow(
                            children: [
                              Container(),
                              Text(
                                '城市',
                                style: TextStyle(
                                    fontSize: 23, color: Color(0xff52616a)),
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
                                style: TextStyle(
                                    fontSize: 23, color: Color(0xff52616a)),
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
                                style: TextStyle(
                                    fontSize: 23, color: Color(0xff52616a)),
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
                                style: TextStyle(
                                    fontSize: 23, color: Color(0xff52616a)),
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
                            style: TextStyle(
                                fontSize: 23, color: Color(0xff52616a)),
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
                            style: TextStyle(
                                fontSize: 23, color: Color(0xff52616a)),
                            textAlign: TextAlign.center,
                          ),
                          DropdownOfNumDog(
                            callback: this.callback,
                            field: 'repeatCount',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screen.height / 100 * 2,
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
                          width: screen.width / 100 * 10,
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
              );
            }),
      ),
    );
  }

  Future<String> get_lon() async {
    var latlng = await Geolocator()
        .getCurrentPosition()
        .timeout(Duration(seconds: 1), onTimeout: () => null);
    if (latlng == null) return null;
    // var data = {'lat': latlng.latitude, 'lon': latlng.longitude};
    var data = {"lat": 24.1755101, "lon": 120.6480756};
    print(data);
    var url = 'http://140.116.152.77:40129/authLocation';
    http.Response response;
    response = await http
        .post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    )
        .timeout(Duration(milliseconds: 1000), onTimeout: () {
      return null;
    }).catchError((onError) {
      return null;
    });
    if (response != null) {
      print(response.body);
      if (jsonDecode(response.body)['success'] == true) {
        print("in");
        return response.body;
      } else {
        return null;
      }
    }
  }

  void callback(String count, String input) {
    //_city,_district,_vilage,_dayCount,_dogCount,_repeatCount;
    print('-----------');
    print('count');
    print(count);
    print('input');
    print(input);
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
    showAlert(context, 0);
    var db = await db_get.create_db();

    var user = await db
        .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
    var imageData = await db.rawQuery(
        'SELECT MAX(id) FROM imagup WHERE user = ${user[0]["user"]} AND plan = ${user[0]["plan"]}');
    print('當前id===================${imageData[0]['MAX(id)']}=使用者 ${user}=====');
    try {
      if (imageData[0]['MAX(id)'] == null) {
        id = user[0]['id'] + 1;
      } else {
        id = imageData[0]['MAX(id)'] + 1;
      }
    } catch (e) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, //點旁邊不關閉
        builder: (context) {
          return AlertDialog(
            title: Text('id 失敗'),
            actions: <Widget>[
              FlatButton(
                child: Text('確定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return null;
    }

    var latlng = await Geolocator().getCurrentPosition().timeout(
      Duration(seconds: 1),
      onTimeout: () {
        return null;
      },
    );
    // db.rawQuery('SELECT MAX(datetime("date")) FROM USERE');
    var data = {
      "id": id,
      "plan": user[0]['plan'],
      "user": user[0]['user'],
      "img": base64Encode(image.readAsBytesSync()),
      "lat": latlng == null ? 0 : latlng.latitude,
      "lon": latlng == null ? 0 : latlng.longitude,
      "city": _city,
      "district": _district,
      "village": _vilage,
      'date': DateTime.now().toIso8601String(),
      "dayCount": _dayCount,
      'dogCount': _dogCount,
      'repeatCount': _repeatCount,
      'update_data': 0,
    };
    try {
      await db.insert("imagup", data);
      await db.update('imagup', {'img': widget.image},
          where:
              'id = $id AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}');
    } catch (text) {
      showDialog<void>(
        context: context,
        barrierDismissible: true, //點旁邊不關閉
        builder: (context) {
          return AlertDialog(
            title: Text("內部資料庫問題"),
            actions: <Widget>[
              Text(text),
              FlatButton(
                child: Text('確定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }
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
    } catch (text) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, //點旁邊不關閉
        builder: (context) {
          return AlertDialog(
            title: Text("上傳失敗"),
            actions: <Widget>[
              FlatButton(
                child: Text('確定'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      response = null;
    }
    Navigator.pop(context); //離開Alert
    if (response != null) //網路確認
    {
      var getJson = jsonDecode(response.body);
      print("資料庫失敗的回傳");
      print(getJson);
      if (getJson['success']) {
        await db.update('imagup', {'update_data': 1},
            where:
                'id = $id AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}');
        showAlert(context, 1);
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false, //點旁邊不關閉
          builder: (context) {
            return AlertDialog(
              title: Text('資料庫失敗'),
              content: Text(getJson),
              actions: <Widget>[
                FlatButton(
                  child: Text('確定'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage(title: '狗狗調查大作戰');
                    }), (route) => false);
                  },
                ),
              ],
            );
          },
        ); //資料庫失敗
      }
    } else {
      await showAlert(context, 2);
    }
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
        return alertLoad(t, context);
      },
    );
  }

  Widget alertLoad(var t, BuildContext context) {
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return MyHomePage(title: '狗狗調查大作戰');
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return MyHomePage(title: '狗狗調查大作戰');
                }), (route) => false);
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
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return MyHomePage(title: '狗狗調查大作戰');
                }), (route) => false);
              },
            ),
          ],
        );
        break;
      default:
    }
  }
}
