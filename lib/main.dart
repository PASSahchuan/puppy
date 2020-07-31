import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:puppy/camera/picture.dart';
import 'package:puppy/database/create_db.dart';
import 'package:puppy/log_in/log_in.dart';
import 'package:sqflite/sqflite.dart';
import 'dropdown/personNum.dart';
import 'page/page1.dart';
import 'page/page2.dart';
import 'page/page3.dart';
import 'package:http/http.dart' as http;

/*  
需要倒入來使用網路與FutureBuilder
   <uses-permission android:name="android.permission.READ_PHONE_STATE" />
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
    
    <uses-permission android:name="android.permission.INTERNET"/> <!-- //FutureBuilder的-->
    */
void main() async {
  await WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); //強制豎屏

  final Database db = await db_get.create_db();
  var temp_user =
      await db.rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');

  var latlng = await Geolocator().getCurrentPosition();
  print("-----------------顯示資料ㄑㄨˋ----------------------");

  print(temp_user);
  print("-----------------開資料ㄑㄨˋ----------------------");
  if (temp_user[0]['user'] != null) {
    var data = {
      'plan': temp_user[0]['plan'],
      'user': temp_user[0]['user'],
      'time': DateTime.now().toIso8601String(),
      'lat': latlng.latitude,
      'lon': latlng.longitude
    };
    // var url = 'http://140.116.152.77:40129/authLocation';
    //   http.Response response;
    //   try {
    //     response = await http
    //         .post(
    //           url,
    //           headers: {'Content-Type': 'application/json'},
    //           body: jsonEncode(data),
    //         )
    //         .timeout(Duration(seconds: 1));
    //     var data_log = await db.query("timingLocation");
    //     for (int i = 0; i < data_log.length; i++) {
    //       response = await http
    //           .post(
    //             url,
    //             headers: {'Content-Type': 'application/json'},
    //             body: jsonEncode(data_log[i]),
    //           )
    //           .timeout(Duration(seconds: 1));
    //       ;
    //     }
    //     db.delete('timingLocation');
    //   } catch (_) {
    //     db.insert("timingLocation", data);
    //   }
  }
  Timer.periodic(Duration(minutes: 1), (timer) async {
    final Database db = await db_get.create_db();
    latlng = await Geolocator().getCurrentPosition();
    if (temp_user.length != 0) {
      var data = {
        'plan': temp_user[0]['plan'],
        'user': temp_user[0]['user'],
        'time': DateTime.now().toIso8601String(),
        'lat': latlng.latitude,
        'lon': latlng.longitude
      };
      var url = 'http://140.116.152.77:40129/timingLocation';
      http.Response response;
      try {
        response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(data),
        );
        var data_log = await db.query("timingLocation");
        for (int i = 0; i < data_log.length; i++) {
          response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data_log[i]),
          );
        }
        db.delete('timingLocation');
      } catch (_) {
        db.insert("timingLocation", data);
      }
    }
  });
  if (temp_user[0]['user'] == null) {
    runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(
        db: db,
      ),
    ));
  } else {
    db.close();
    runApp(MyApp());
  }
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
  int sw = 1;
  int _index = 0;
  List<Widget> page = List<Widget>();
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          DropdownOfPerson(),
                          SizedBox(
                            width: 15,
                          ),
                          FlatButton(
                            color: sw == 1 ? Color(0xffDB6400) : Colors.white,
                            child: Text(
                              '已上傳',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              sw = 1;
                              setState(() {});
                            },
                            textColor:
                                sw == 1 ? Colors.white : Color(0xffDB6400),
                          ),
                          FlatButton(
                            color: sw == 0 ? Color(0xffDB6400) : Colors.white,
                            child: Text(
                              '未上傳',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: () {
                              sw = 0;
                              setState(() {});
                            },
                            textColor:
                                sw == 0 ? Colors.white : Color(0xffDB6400),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          FlatButton(
                            textColor: Color(0xffDB6400),
                            onPressed: get_album,
                            child: Icon(
                              Icons.add_photo_alternate,
                              size: 40,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Container(
                color: Colors.blue[50],
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 280,
                      child: FutureBuilder(
                        key: UniqueKey(),
                        future: get_db_data(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Widget>> text) {
                          // showDialog<void>(
                          //   context: context,
                          //   barrierDismissible: true, //點旁邊不關閉
                          //   builder: (context) {
                          //     return AlertDialog(
                          //       title: Text("Errror"),
                          //       actions: <Widget>[
                          //         Text(text.error),
                          //         FlatButton(
                          //           child: Text('確定'),
                          //           onPressed: () {
                          //             Navigator.of(context).pop();
                          //           },
                          //         ),
                          //       ],
                          //     );
                          //   },
                          // );

                          // print(
                          //     'page內容${text.data.length}'); //莫名其妙的bug不print apk就跑不出來
                          return PageView(
                              controller: PageController(
                                viewportFraction: 0.9,
                                initialPage: 0,
                              ),
                              onPageChanged: (int index) {
                                _index = index;
                              },
                              children: text.data);
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    // Text(
                    //   '1/46',
                    //   style: TextStyle(fontSize: 25),
                    // ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Color(0xffDB6400),
                    child: Text(
                      '照片上傳',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.normal),
                    ),
                    onPressed: sw == 0 ? upload : () {},
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  RaisedButton(
                    color: Color(0xffDB6400),
                    child: Text(
                      '拍攝照片',
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.normal),
                    ),
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

  void upload() async {
    if (page.length == 0) {
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false, //點旁邊不關閉
      builder: (context) {
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
      },
    );
    print(
        "1==================================================================");
    var db = await db_get.create_db();
    var user = await db
        .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
    var data = await db.query("imagup",
        where:
            'update_data = $sw AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}',
        orderBy: "datetime('date')");
    data = data.reversed.toList();
    print(_index);
    print(data[_index]);
    print(
        "2==================================================================");

    var upData = {
      "id": data[_index]['id'],
      "plan": data[_index]['plan'],
      "user": data[_index]['user'],
      "img": base64Encode(File(data[_index]['img']).readAsBytesSync()),
      "lat": data[_index]['lat'],
      "lon": data[_index]['lon'],
      "city": data[_index]['city'],
      "district": data[_index]['district'],
      "village": data[_index]['village'],
      'date': data[_index]['date'],
      "dayCount": data[_index]['dayCount'],
      'dogCount': data[_index]['dogCount'],
      'repeatCount': data[_index]['repeatCount'],
      'update_data': 0,
    };
    var url = 'http://140.116.152.77:40129/img_upload';
    http.Response response;
    print(
        "3==================================================================");

    try {
      print(
          "4-1==================================================================");

      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(upData),
          )
          .timeout(
            Duration(seconds: 15),
            onTimeout: () => null,
          );
      print(response.body);
      print(
          "4-1-end==================================================================");
      Navigator.of(context).pop();
    } catch (text) {
      print(
          "4-2==================================================================");
      Navigator.of(context).pop();

      showDialog<void>(
        context: context,
        barrierDismissible: true, //點旁邊不關閉
        builder: (context) {
          return AlertDialog(
            title: Text("與伺服器連線失敗"),
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
      print(
          "4-2-end==================================================================");
      return;
    }

    var getJson = jsonDecode(response.body);
    if (getJson['success']) {
      await db.update('imagup', {'update_data': 1},
          where:
              'id = ${data[_index]["id"]} AND plan = ${data[_index]['plan']} AND user = ${data[_index]['user']}');
      db.close();
      showDialog<void>(
        context: context,
        barrierDismissible: false, //點旁邊不關閉
        builder: (context) {
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
        },
      );
    } else {
      showDialog<void>(
        context: context,
        barrierDismissible: false, //點旁邊不關閉
        builder: (context) {
          return AlertDialog(
            title: Text('資料衝突'),
            content: Text(
                '衝突資料id：${getJson["id"]}\n錯誤訊息：${getJson['msg']}\n是否歸類到已上傳？'),
            actions: <Widget>[
              FlatButton(
                child: Text('是'),
                onPressed: () async {
                  await db.update('imagup', {'update_data': 1},
                      where:
                          'id = ${data[_index]["id"]} AND plan = ${data[_index]['plan']} AND user = ${data[_index]['user']}');
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('否'),
              ),
            ],
          );
        },
      );
    }

    setState(() {});
  }

  Future<List<Widget>> get_db_data() async {
    page = List<Widget>();
    try {
      var db = await db_get.create_db();

      var user = await db
          .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
      var data = await db.query("imagup",
          where:
              'update_data = $sw AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}',
          orderBy: "datetime('date')");
      print("長度-------------${data.length}");
      print("內容-------------${data}");
      for (var i = 1; i <= data.length; i++) {
        print(data[data.length - i]['date']);
        page.add(Page1(b: data[data.length - i]));
      }
    } catch (e) {
      page.add(Page3());
    }
    return page;
  }

  void takePicture() {
    picture com = picture(context: context, is_camera: true);
    com.getPicture();
    print('take picture success!');
  }

  void get_album() {
    picture com = picture(context: context, is_camera: false);
    com.getPicture();
    print('take pictur album success!');
  }

  Future<List<String>> user_data_get_list() async {
    var db = db_get.create_db();

    return null;
  }
}
