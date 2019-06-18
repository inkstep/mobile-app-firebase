import 'package:flutter/material.dart';

class EnterExitRoute extends PageRouteBuilder<dynamic> {
  EnterExitRoute({this.exitPage, this.enterPage, bool back})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              enterPage,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              Stack(
                children: <Widget>[
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset.zero,
                      end: Offset(0.0, back ? 1.0 : -1.0),
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Interval(
                          0.50,
                          1.00,
                          curve: Curves.linear,
                        ),
                      ),
                    ),
                    child: exitPage,
                  ),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.0, back ? -1.0 : 1.0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Interval(
                          0.50,
                          1.00,
                          curve: Curves.linear,
                        ),
                      ),
                    ),
                    child: enterPage,
                  )
                ],
              ),
        );

  final Widget enterPage;
  final Widget exitPage;
}
