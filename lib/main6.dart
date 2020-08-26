import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_save/image_save.dart';
import 'package:puppy/database/create_db.dart';
import 'package:puppy/main.dart';
import 'package:puppy/test/stupid.dart';
import 'dropdown/DropdownDistrict.dart';
import 'dropdown/DropdownTown.dart';
import 'dropdown/DropdownVillage.dart';
import 'dropdown/DropdownOfDay.dart';
import 'dropdown/DropdownOfNumDog.dart';
import 'package:http/http.dart' as http;
import 'dart:ui' as ui;

class MyHomePage2 extends StatefulWidget {
  MyHomePage2({Key key, this.title, @required this.image}) : super(key: key);

  final String title;
  final String image;

  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  File image;
  String _gps_city = null,
      _gps_dis = null,
      _gps_vil = null,
      _city = city_record,
      _district = district_record,
      _vilage = village_record,
      _dayCount = '0',
      _dogCount = '0',
      _repeatCount = '0';
  int id;
  double gps_lat = 0, gps_lon = 0;
  GlobalKey _repaintKey = GlobalKey();
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
          child: Container(
        // height: MediaQuery.of(context).size.height,
        // width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(25),
        alignment: Alignment.center,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            RepaintBoundary(
              key: _repaintKey,
              child: Container(
                alignment: Alignment.center,
                child: Stack(children: <Widget>[
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
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data != null) {
                              gps_lat = snapshot.data.latitude;
                              gps_lon = snapshot.data.longitude;
                              return Text(
                                'lon: ${snapshot.data.longitude} lat: ${snapshot.data.latitude} ',
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        (0.8 * 255).toInt(), 139, 69, 19)),
                              );
                            } else {
                              return Text(
                                '讀取中',
                                style: TextStyle(
                                    color: Color.fromARGB(
                                        (0.8 * 255).toInt(), 139, 69, 19)),
                              );
                            }
                          })
                    ],
                  ),
                ]),
              ),
            ),
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
                      TextField(
                        style: TextStyle(color: Color(0xffD09E88)),
                        keyboardType: TextInputType.number,
                        onChanged: (String text) {
                          _dayCount = text;
                        },
                        // controller: _dayCount,
                        autofocus: false,
                      ),
                      // DropdownOfDay(
                      //   callback: this.callback,
                      //   field: 'dayCount',
                      // ),
                      Container(),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.blueGrey,
              indent: 20,
              endIndent: 20,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '照片中有幾隻狗',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: screen.width / 100 * 15,
                    child: TextField(
                      style: TextStyle(color: Color(0xffD09E88)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,

                      // controller: _dogCount,
                      onChanged: (String text) {
                        _dogCount = text;
                      },
                      autofocus: false,
                      decoration: new InputDecoration(
                        labelStyle: new TextStyle(
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ),
                    // DropdownOfNumDog(
                    //   callback: this.callback,
                    //   field: 'dogCount',
                    // ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    '照片中的狗有幾隻與之前重複',
                    style: TextStyle(fontSize: 23, color: Color(0xff52616a)),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    width: screen.width / 100 * 10,
                    child: TextField(
                      style: TextStyle(color: Color(0xffD09E88)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,

                      onChanged: (String text) {
                        _repeatCount = text;
                      },
                      // controller: ,
                      autofocus: false,
                    ),
                  ),
                  // DropdownOfNumDog(
                  //   callback: this.callback,
                  //   field: 'repeatCount',
                  // ),
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
      )),
    );
  }

  Future<String> get_lon(var latitude, longitude) async {
    var data = {'lat': latitude, 'lon': longitude};
    // var data = {"lat": 24.1755101, "lon": 120.6480756};
    print('這是關羽取得城市鄉政地址');
    print(data);
    var url = 'http://140.116.152.77:40129/authLocation';
    http.Response response = null;
    response = await http
        .post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    )
        .timeout(Duration(milliseconds: 1000), onTimeout: () {
      response = null;
      return null;
    }).catchError((onError) {
      response = null;
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
    print(_repeatCount);
    print(_dayCount);
    print(_dogCount);
    if (_dogCount == '0' || int.parse(_dogCount) < int.parse(_repeatCount)) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('數據錯誤'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('遊蕩犬數量不能為0'),
                  Text('照片中遊蕩犬重複數量不得大於原有數量'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('ok'),
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
    bool gps_sw = false;
    if (gps_lat == 0 || gps_lon == 0) {
      await showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('gps未取得'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('目前gps讀取中請問是否跳過'),
                  Text("跳過將沒有gps資料"),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('跳過'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                onPressed: () {
                  gps_sw = true;
                  Navigator.of(context).pop();
                },
                child: Text('等待'),
              ),
            ],
          );
        },
      );
    } else {
      var geography =
          await get_lon(gps_lat, gps_lon).timeout(Duration(seconds: 1));
      if (geography != null) {
        var geography_json = jsonDecode(geography);
        if (geography_json['success']) {
          _gps_city = geography_json['city'];
          _gps_dis = geography_json['suburb'];
          _gps_vil = geography_json['city_district'];
          await showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('GPS定位成功'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text('目前gps讀取到的城市為$_gps_city $_gps_dis $_gps_vil'),
                      Text("您填寫的資料為$_city $_district $_vilage"),
                      Text("您選的資料是否正確")
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text('正確'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      gps_sw = true;
                      Navigator.of(context).pop();
                    },
                    child: Text('更改問卷'),
                  ),
                ],
              );
            },
          );
        }
      } else if (_gps_city != null) {
        await showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('網路失敗顯示儲存資料'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('目前gps儲存為$_gps_city $_gps_dis $_gps_vil'),
                    Text("您填寫的資料為$_city $_district $_vilage"),
                    Text("您選的資料是否正確")
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('正確'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  onPressed: () {
                    gps_sw = true;
                    Navigator.of(context).pop();
                  },
                  child: Text('取消'),
                ),
              ],
            );
          },
        );
      }
    }

    if (gps_sw == true) {
      print("有沒有停下");
      return;
    }
    showAlert(context, 0);

    print('測試儲存相片');
    RenderRepaintBoundary boundary =
        _repaintKey.currentContext.findRenderObject();
    print("測試相簿459行");
    ui.Image _image_save = await boundary.toImage(pixelRatio: 5.0);
    print("測試相簿461行");
    ByteData byteData =
        await _image_save.toByteData(format: ui.ImageByteFormat.png);
    print("測試相簿464行");

    Uint8List pngBytes = byteData.buffer.asUint8List();
    print("測試相簿467行");

    print(pngBytes);
    ImageSave.saveImage(pngBytes, "png", albumName: "dog");
    print("測試相簿471行");

    cityChange = false;
    distinctChange = false;
    var db = await db_get.create_db();

    var user = await db
        .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
    var imageData = await db.rawQuery(
        "SELECT MAX(id) FROM imagup WHERE user = '${user[0]["user"]}' AND plan = '${user[0]["plan"]}'");
    print('當前id===================${imageData[0]['MAX(id)']}=使用者 ${user}=====');
    try {
      if (imageData[0]['MAX(id)'] == null ||
          user[0]['id'] > imageData[0]['MAX(id)']) {
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
    print("596");
    // db.rawQuery('SELECT MAX(datetime("date")) FROM USERE');
    var data = {
      "id": id,
      "plan": user[0]['plan'],
      "user": user[0]['user'],
      "img": base64Encode(image.readAsBytesSync()),
      "lat": gps_lat,
      "lon": gps_lon,
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
              "id = $id AND plan = '${user[0]["plan"]}' AND user = '${user[0]["user"]}'");
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
            headers: {
              'Content-Type': 'application/json',
              'connection': 'keep-alive'
            },
            body: jsonEncode(data),
          )
          .timeout(
            Duration(seconds: 35),
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
                "id = $id AND plan = '${user[0]["plan"]}' AND user = '${user[0]["user"]}'");
        showAlert(context, 1);
      } else {
        showDialog<void>(
          context: context,
          barrierDismissible: false, //點旁邊不關閉
          builder: (context) {
            return AlertDialog(
              title: Text('資料庫失敗'),
              content: Text(response.body),
              actions: <Widget>[
                FlatButton(
                  child: Text('確定'),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage();
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
    cityChange = false;
    distinctChange = false;
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
                  return MyHomePage();
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
                  return MyHomePage();
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
                  return MyHomePage();
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
