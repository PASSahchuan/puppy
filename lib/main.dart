import 'dart:async';
import 'dart:convert';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]); //強制豎屏

  final Database db = await db_get.create_db();
  var temp_user =
      await db.rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
  var latlng = await Geolocator().getCurrentPosition();
  print(temp_user);
  if (temp_user[0]['user'] != null) {
    var data = {
      'plan': temp_user[0]['plan'],
      'user': temp_user[0]['user'],
      'time': DateTime.now().toIso8601String(),
      'lat': latlng.latitude,
      'lon': latlng.longitude
    };
    var url = 'http://140.116.152.77:40129/authLocation';
    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(Duration(seconds: 1));
      var data_log = await db.query("timingLocation");
      for (int i = 0; i < data_log.length; i++) {
        response = await http
            .post(
              url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data_log[i]),
            )
            .timeout(Duration(seconds: 1));
        ;
      }
      db.delete('timingLocation');
    } catch (_) {
      db.insert("timingLocation", data);
    }
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
      var url = 'http://140.116.152.77:40129/authLocation';
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
  List<Widget> page = List<Widget>();
  @override
  @override
  Widget build(BuildContext context) {
    get_db_data();
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
                            color: Color(0xffDB6400),
                            child: Text(
                              '已上傳',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: takePicture,
                            textColor: Colors.white,
                          ),
                          FlatButton(
                            color: Colors.white,
                            child: Text(
                              '未上傳',
                              style: TextStyle(fontSize: 18),
                            ),
                            onPressed: takePicture,
                            textColor: Color(0xffDB6400),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '囗',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 250,
                    height: 280,
                    child: FutureBuilder(
                      future: get_db_data(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Widget>> text) {
                        if (true) {
                          return PageView(
                              controller: PageController(
                                viewportFraction: 0.9,
                              ),
                              onPageChanged: (int index) {},
                              children: text.data);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Stack(
                  //   children: <Widget>[
                  //     Container(
                  //       padding: EdgeInsets.only(top: 30, bottom: 100),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           CardModel(),
                  //           SizedBox(
                  //             width: 20,
                  //           ),
                  //           CardModel(),
                  //         ],
                  //       ),
                  //     ),
                  //     Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         CardModel(),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  Text(
                    '1/46',
                    style: TextStyle(fontSize: 25),
                  ),
                ],
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
                    onPressed: upload,
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
    print('upload success!');

    //print(response.body);
    print("object");
  }

  Future<List<Widget>> get_db_data() async {
    var db = await db_get.create_db();
    var user = await db
        .rawQuery('SELECT plan,user,id,MAX(datetime("date")) FROM USERE');
    var data = await db.query("imagup",
        where:
            'update_data = 0 AND plan = ${user[0]["plan"]} AND user = ${user[0]["user"]}',
        orderBy: "datetime('date')");
    print("object");

    for (var i = 0; i < data.length; i++) {
      print(base64Decode(data[i]['img']));
      page.add(Page2(b: data[0]['img']));
    }
    return page;
  }

  void takePicture() {
    picture com = picture(context: context);
    com.getPicture();
    print('take picture success!');
  }
}
