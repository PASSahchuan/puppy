import 'package:image_picker/image_picker.dart'; //拍照
import 'dart:io'; //File處理
import 'package:image_save/image_save.dart'; //存照片
import 'package:flutter/material.dart';
import 'package:puppy/main6.dart' as question;

class picture {
  picture({this.context, @required this.is_camera});
  BuildContext context;
  bool is_camera;
  void getPicture() async {
    var getimage = ImagePicker();
    var image;
    if (is_camera) {
      image = await getimage.getImage(source: ImageSource.camera);
    } else {
      image = await getimage.getImage(source: ImageSource.gallery);
    }
    if (image == null) {
      return;
    }
    File _image = File(image.path);
    print("======路徑5這裡=======");
    print(image.path);
    if (is_camera) {
      await ImageSave.saveImage(_image.readAsBytesSync(), "jpg",
          albumName: "dog");
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return question.MyHomePage2(
          image: image.path,
          title: '遊蕩犬調查',
        );
      }),
    );
  }
}
