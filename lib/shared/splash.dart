import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Transform.scale(
                scale: 7.5,
                child: IconButton(
                  onPressed: () {},
                  icon: new Image.asset("assets/school_icon.png"),
                ),
              ),
            ),
            //SizedBox(height: 30.0),
            //Text('From'),
            //Text('Navodika Karunasingha'),
          ],
        ), /**/
      ),
    );
  }
}
