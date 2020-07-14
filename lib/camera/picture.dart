import 'package:image_picker/image_picker.dart'; //拍照
import 'dart:io'; //File處理
import 'package:image_save/image_save.dart'; //存照片

class picture {
  static void getPicture() async {
    var getimage = ImagePicker();
    var image = await getimage.getImage(source: ImageSource.camera);
    File _image = File(image.path);
    await ImageSave.saveImage(_image.readAsBytesSync(), "jpg",
        albumName: "demo");
  }
}
