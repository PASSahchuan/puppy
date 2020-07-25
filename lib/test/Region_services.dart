import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:async';

Future<String> _loadRegionJson() async {
  // print(await rootBundle.loadString('assets/data.json'));
  return await rootBundle.loadString('assets/data.json');
}

Future<List> decodeRegion(String selectdCity) async {
// 獲取本地的 json 字符串
  String regionJson = await _loadRegionJson();
// 解析 json 字符串，返回的是 Map<String, dynamic> 類型
  final jsonMap = json.decode(regionJson);
  print(jsonMap[selectdCity].keys.toList());
  // print('jsonMap runType is ${jsonMap.runtimeType}');
  return jsonMap[selectdCity].keys.toList();
}
