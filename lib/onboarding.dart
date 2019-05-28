import 'package:flutter/material.dart';
import 'package:inkstep/logo.dart';
import 'package:inkstep/theming.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'info_gathering.dart';
import 'main.dart';
import 'onboarding/default_flow_button.dart';
import 'onboarding/user_flow_button.dart';

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  String _name = '';

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
          DefaultFlowButton(destination: NewJourneyRoute()),
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
