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
import 'page/page1.dart';
import 'page/page2.dart';
import 'page/page3.dart';
import 'package:http/http.dart' as http;

var user_name = '';

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
  var temp_user = await db
      .rawQuery('SELECT plan,user,name,id,MAX(datetime("date")) FROM USERE');

  Geolocator().getCurrentPosition();

  Timer.periodic(Duration(minutes: 1), (timer) async {
    try {
      final Database db = await db_get.create_db();
      var temp_user = await db
          .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');

      var latlng = await Geolocator().getCurrentPosition();
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
        } catch (_) {
          db.insert("timingLocation", data);
        }
        var data_log = await db.query("timingLocation");
        for (int i = 0; i < data_log.length; i++) {
          sleep(Duration(seconds: 1));
          response = await http.post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data_log[i]),
          );
        }
        db.delete('timingLocation');
      }
    } catch (_) {}
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
    user_name = temp_user[0]['name'];
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
      home: MyHomePage(),
      // routes: <String, WidgetBuilder>{'/TwoButtom': (_) => new TwobuttomPage()},
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  String title = '哈囉~ $user_name';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int sw = 1; //1 已上傳 0 未上傳
  int _index = 0;
  List<Widget> page = List<Widget>();

  @override
  Widget build(BuildContext context) {
    var screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                          Container(
                            child: FlatButton(
                              color: Colors.white,
                              child: Text(
                                '重新登入',
                                style: TextStyle(fontSize: 12),
                              ),
                              onPressed: () async {
                                var db = await db_get.create_db();
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return LoginPage(db: db);
                                }));
                              },
                              textColor: Color(0xffDB6400),
                            ),
                          ), //k
                          SizedBox(
                            width: screen.width / 100 * 3,
                          ),
                          FlatButton(
                            color: sw == 1 ? Color(0xffDB6400) : Colors.white,
                            child: Text(
                              '已上傳',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              sw = 1;
                              setState(() {});
                            },
                            textColor:
                                sw == 1 ? Colors.white : Color(0xffDB6400),
                          ), //k
                          FlatButton(
                            color: sw == 0 ? Color(0xffDB6400) : Colors.white,
                            child: Text(
                              '未上傳',
                              style: TextStyle(fontSize: 15),
                            ),
                            onPressed: () {
                              sw = 0;
                              setState(() {});
                            },
                            textColor:
                                sw == 0 ? Colors.white : Color(0xffDB6400),
                          ),
                          SizedBox(
                            width: screen.width / 100 * 10,
                            height: screen.height / 100 * 4.5,
                            // width: 40,
                            // height: 40,
                            child: FlatButton(
                              textColor: Color(0xffDB6400),
                              onPressed: get_album,
                              child: Icon(
                                Icons.add_photo_alternate,
                                size: screen.width / 100 * 9,
                              ),
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
                      width: screen.width / 100 * 70,
                      height: screen.height / 100 * 40,
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

                          print(
                              'page內容${text.data.length}'); //莫名其妙的bug不print apk就跑不出來
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
                  sw == 1
                      ? Container(
                          width: 0,
                          height: 0,
                        )
                      : RaisedButton(
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
                    width: sw == 1 ? 0 : 30,
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
            "update_data = $sw AND plan = '${user[0]["plan"]}' AND user = '${user[0]["user"]}'",
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
              "id = ${data[_index]["id"]} AND plan = '${data[_index]['plan']}' AND user = '${data[_index]['user']}'");
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
                          "id = ${data[_index]["id"]} AND plan = '${data[_index]['plan']}' AND user = '${data[_index]['user']}'");
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

  void set_state() {
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
              "update_data = $sw AND plan = '${user[0]["plan"]}' AND user = '${user[0]["user"]}'",
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
    var db = await db_get.create_db();
    var plan_user_db = await db.query("USERE", orderBy: 'datetime("date")');
    plan_user_db = plan_user_db.reversed.toList();
    List<String> plan_user_List = List<String>();
    for (var i = 0; i < plan_user_db.length; i++) {
      var plan_str = plan_user_db[i]['plan'].padLeft(1, '0');
      var user_str = plan_user_db[i]['user'].padLeft(2, '0');
      plan_user_List.add('$plan_str\\$user_str');
    }
    return plan_user_List;
  }
}
