import 'package:image_picker/image_picker.dart'; //拍照
import 'dart:io'; //File處理
import 'package:image_save/image_save.dart'; //存照片
import 'package:flutter/material.dart';
import 'package:puppy/main6.dart' as question;

class picture {
  picture({this.context});
  BuildContext context;
  Function callback;
  void getPicture() async {
    var getimage = ImagePicker();
    var image = await getimage.getImage(source: ImageSource.camera);
    File _image = File(image.path);
    print("======路徑5這裡=======");
    print(image.path);
    print("+");
    await ImageSave.saveImage(_image.readAsBytesSync(), "jpg",
        albumName: "dog");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return question.MyHomePage2(
          image: image.path,
          title: '狗狗調查大作戰',
        );
      }),
    );
  }
}
