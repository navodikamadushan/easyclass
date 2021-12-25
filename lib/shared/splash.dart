import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Transform.scale(
          scale: 5.5,
          child: IconButton(
            onPressed: () {},
            icon: new Image.asset("assets/eassyclass_icon.png"),
          ),
        ),
      ),
    );
  }
}
