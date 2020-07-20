import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
void main() {
  runApp(Body());
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Categories(),
      ],
    );
  }
}

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["已上傳", "上傳失敗", "未上傳"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20,),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => bulidCategoriItem(index),
        ),
      ),
    );
  }

  Widget bulidCategoriItem(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color:
                selectedIndex == index ? Color(0xffeff3ee) : Colors.transparent,
            borderRadius: BorderRadius.circular(16)),
        child: Text(categories[index],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedIndex == index
                  ? Colors.deepOrangeAccent
                  : Color(0xffc2c2b5),
            )),
      ),
    );
  }
}
