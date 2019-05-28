import 'package:flutter/material.dart';
import 'package:inkstep/theming.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_gathering.dart';
import 'main.dart';
import 'onboarding/user_flow_button.dart';

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Image.asset('assets/images/logo.png'),
      );
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) => Center(
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Container(
                  height: animation.value,
                  width: animation.value,
                  child: child,
                ),
            child: child),
      );
}

class Logo extends StatefulWidget {
  _LogoState createState() => _LogoState();
}

class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  final startSize = 80.0;
  final endSize = 90.0;
  final duration = Duration(seconds: 2);

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
    animation =
        Tween<double>(begin: startSize, end: endSize).animate(controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller.reverse();
            } else if (status == AnimationStatus.dismissed) {
              controller.forward();
            }
          })
          ..addStatusListener((state) => print('$state'));
    controller.forward();
  }
  // #enddocregion print-state

  @override
  Widget build(BuildContext context) => GrowTransition(
        child: Hero(tag: 'logo', child: LogoWidget()),
        animation: animation,
      );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  String _name = "";

  Future<String> getNamePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('name') ?? '';
    });
    return prefs.getString('name') ?? '';
  }

  Widget _sub(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey,
          fontSize: 25.0,
          fontFamily: 'Signika',
          fontWeight: FontWeight.w100),
    );
  }

  Widget _header(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontFamily: 'Signika',
          fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    final top = Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: Center(
        child: Column(
          children: <Widget>[
            Logo(),
            _header('Hi there,'),
            _header("We're here to help"),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
            ),
            _sub('Every step'),
            _sub('of the way'),
          ],
        ),
      ),
    );

    final bottom = Container(
      child: Column(
        children: <Widget>[
          DefaultFlowButton(),
          Padding(padding: EdgeInsets.only(top: 32.0)),
          UserFlowButton(destination: TopTabs()),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[
          top,
          Padding(padding: EdgeInsets.only(top: 275.0)),
          bottom
        ],
      ),
      backgroundColor: darkColor,
    );
  }
}

class DefaultFlowButton extends StatelessWidget {
  const DefaultFlowButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
                builder: (context) => NewJourneyRoute()));
      },
      elevation: 15.0,
      color: Colors.white,
      textColor: darkColor,
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        "Let's get started!",
        style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
      ),
    );
  }
}
