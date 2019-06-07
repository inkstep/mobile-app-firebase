// Ref: https://medium.com/@agungsurya/create-custom-router-transition-in-flutter-using-pageroutebuilder-73a1a9c4a171
// Ref: Tween: https://flutterbyexample.com/step-one-tweening/

import 'package:flutter/material.dart';

class ScaleRoute extends PageRouteBuilder<dynamic> {
  ScaleRoute({@required this.child, @required this.rect})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return child;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return Stack(
              children: [
                Container(),
                PositionedTransition(
                  child: child,
                  rect: RelativeRectTween(
                    begin: rect,
                    end: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
                  ).animate(animation),
                ),
              ],
            );
          },
          transitionDuration: Duration(milliseconds: 300),
        );

  final Widget child;
  final RelativeRect rect;
}
