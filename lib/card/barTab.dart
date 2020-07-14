import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../test/unUpload.dart';
import '../test/upload.dart';
import '../test/uploadFailed.dart';

void main() {
  runApp(BarTab());
}

class BarTab extends StatelessWidget {
  final List<Tab> myTabs = <Tab>[
    Tab(text: '已上傳'),
    Tab(text: '上傳失敗'),
    Tab(text: '未上傳'),
  ];

  final pages = [Upload(), UploadFailed(), UnUpload()];

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: DefaultTabController(
        length: myTabs.length, //選項卡頁數
        child: Scaffold(
          appBar: AppBar(
            title: Text("HKＴ線上教室"),
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
          body: TabBarView(
            children: <Widget>[Upload(), UploadFailed(), UnUpload()],
          ),
        ),
      ),
    );
  }
}
