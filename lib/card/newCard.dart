import 'package:flutter/material.dart';
import '../card/Text.dart';
import '../card/mask.dart';

class newCard extends StatefulWidget {
  @override
  _newCardState createState() => _newCardState();
}

class _newCardState extends State<newCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset('assets/mainDog.jpg'),
            imageOverlayGradient,
            buildTextContainer(),
          ],
        ),
      ),
    );
  }
}