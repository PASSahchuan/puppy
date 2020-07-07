import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  CustomButton({@required this.onPressed});
  GestureTapCallback onPressed;

@override
  Widget build(BuildContext context) {
    return Text('Tap me');
  }
}