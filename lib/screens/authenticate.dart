// All right reserved by EasyClass
// Auther Information :- Navodika Karunasingha (eng.navodika@gmail.com)

import 'package:flutter/material.dart';
import 'package:easyclass/screens/signinpage.dart';
import 'package:easyclass/screens/register.dart';
import 'package:animations/animations.dart';

class Authenticate extends StatefulWidget {
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) => PageTransitionSwitcher(
        duration: Duration(milliseconds: 1000),
        reverse: showSignIn,
        transitionBuilder: (child, animation, secondaryAnimation) => SharedAxisTransition(
          child: child,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
        ),
        child: showSignIn ? SignInPage(toggleView: toggleView) : Register(toggleView: toggleView),
      );
}
