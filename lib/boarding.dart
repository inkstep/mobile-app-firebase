import 'package:flutter/material.dart';
import 'package:inkstep/theming.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_gathering.dart';
import 'main.dart';

// #docregion LogoWidget
class LogoWidget extends StatelessWidget {
  // Leave out the height and width so it fills the animating parent
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Image.asset("assets/images/logo.png"),
      );
}
// #enddocregion LogoWidget

// #docregion GrowTransition
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
// #enddocregion GrowTransition

class Logo extends StatefulWidget {
  _LogoState createState() => _LogoState();
}

// #docregion print-state
class _LogoState extends State<Logo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 80, end: 90).animate(controller)
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
// #docregion print-state
}

class Boarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BoardingState();
}

class _BoardingState extends State<Boarding> with TickerProviderStateMixin {
  String _name = "";

  Future<String> getNamePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString("name") ?? "";
    });
    return prefs.getString("name") ?? "";
  }

  Widget subheader(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey,
          fontSize: 25.0,
          fontFamily: "Signika",
          fontWeight: FontWeight.w100),
    );
  }

  Widget header(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontFamily: "Signika",
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
            header('Hi there,'),
            header("We're here to help"),
            Padding(
              padding: const EdgeInsets.only(top: 64.0),
            ),
            subheader('Every step'),
            subheader('of the way'),
          ],
        ),
      ),
    );

    final bottom = Container(
      child: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewJourneyRoute()));
            },
            elevation: 15.0,
            color: Colors.white,
            textColor: darkColor,
            padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            child: Text(
              "Let's get started!",
              style: TextStyle(fontSize: 20.0, fontFamily: "Signika"),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 32.0)),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TopTabs()));
            },
            child: Text(
              "I'M ON A NEW DEVICE",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontFamily: "Signika",
              ),
            ),
          ),
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
