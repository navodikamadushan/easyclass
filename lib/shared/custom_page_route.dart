import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  final Widget child;
  CustomPageRoute({
    this.child,
  }) : super(
          transitionDuration: Duration(seconds: 2),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  @override
  Widget buildTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) => ScaleTransition(
        scale: animation,
        child: child,
      );
}
