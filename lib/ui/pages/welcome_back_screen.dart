import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WelcomeBackScreen extends StatefulWidget {
  const WelcomeBackScreen({Key key, this.name, this.loading = false}) : super(key: key);

  final String name;
  final bool loading;

  @override
  State<StatefulWidget> createState() => WelcomeBackScreenState(name, loading);
}

class WelcomeBackScreenState extends State<WelcomeBackScreen> with SingleTickerProviderStateMixin {
  WelcomeBackScreenState(this.name, this.loading);

  final String name;
  final bool loading;

  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        children: <Widget>[
          Spacer(flex: 10),
          Center(
            child: SlideTransition(
              position: _offsetAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Container(
                    child: Text(
                      name ?? '',
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(flex: 1),
          Spacer(flex: 6),
          if (loading)
            SpinKitChasingDots(
              color: Theme.of(context).cardColor,
              size: 50.0,
            ),
          Spacer(flex: 10),
        ],
      ),
    );
  }
}
