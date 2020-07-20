import 'package:flutter/material.dart';
import 'package:puppy/camera/picture.dart';
import 'package:puppy/log_in/log_in.dart';
import 'dropdown/personNum.dart';
import 'page/page1.dart';
import 'page/page2.dart';
import 'page/page3.dart';

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
                    child: PageView(
                      controller: PageController(
                        viewportFraction: 0.9,
                      ),
                      onPageChanged: (int index) {},
                      children: <Widget>[
                        Page1(),
                        Page2(),
                        Page3(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
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

  void upload() {
    print('upload success!');
  }

  void takePicture() {
    picture com = picture(context: context);
    com.getPicture();
    print('take picture success!');
  }
}
