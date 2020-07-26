// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'dart:async';

// String selectedCity;

// Future<String> _loadRegionJson() async {
//   // print(await rootBundle.loadString('assets/data.json'));
//   return await rootBundle.loadString('assets/data.json');
// }

// Future<List<String>> decodeRegion(String selected) async {
// // 獲取本地的 json 字符串
//   selectedCity = selected;
//   String regionJson = await _loadRegionJson();
// // 解析 json 字符串，返回的是 Map<String, dynamic> 類型
//   final jsonMap = json.decode(regionJson);
//   print(jsonMap[selected].keys.toList());
//   // print('jsonMap runType is ${jsonMap.runtimeType}');
//   return jsonMap[selected].keys.toList();
// }

// Future<List<String>> decodevillage(String selected) async {
// // 獲取本地的 json 字符串
//   String regionJson = await _loadRegionJson();
// // 解析 json 字符串，返回的是 Map<String, dynamic> 類型
//   final jsonMap = json.decode(regionJson);
//   print(jsonMap[selectedCity][selected].toList());
//   // print('jsonMap runType is ${jsonMap.runtimeType}');
//   return jsonMap[selectedCity][selected].toList();
// }
