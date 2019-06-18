import 'package:flutter/material.dart';

class FadeRoute extends PageRouteBuilder<dynamic> {
  FadeRoute({this.page})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Interval(
              0.00,
              1.00,
              curve: Curves.easeIn,
            ),
          ),
          child: child,
        ),
  );

  final Widget page;
}

