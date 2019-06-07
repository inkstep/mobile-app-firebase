import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/ui/components/logo.dart';
import 'package:inkstep/ui/components/text_button.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class Onboarding extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> with TickerProviderStateMixin {
  _OnboardingState();

  Widget _sub(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.grey, fontSize: 25.0, fontFamily: 'Signika', fontWeight: FontWeight.w100),
    );
  }

  Widget _header(String text) {
    return Text(
      text,
      style: TextStyle(
          color: baseColors['light'],
          fontSize: 40.0,
          fontFamily: 'Signika',
          fontWeight: FontWeight.w600),
    );
  }

  @override
  Widget build(BuildContext context) {
    const EdgeInsets topPadding = EdgeInsets.only(top: 120.0);
    final top = Padding(
      padding: topPadding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Logo(),
                  _header('Hi there,'),
                  _header("We're here to help"),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  _sub('Every step'),
                  _sub('of the way'),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    const EdgeInsets buttonPadding = EdgeInsets.only(top: 32.0);
    final ScreenNavigator nav = sl.get<ScreenNavigator>();
    final bottom = Container(
      child: Column(
        children: <Widget>[
          BoldCallToAction(
            onTap: () {
              nav.openArtistSelection(context);
            },
            label: "Let's get started!",
            textColor: Theme.of(context).primaryColor,
            color: Theme.of(context).cardColor,
          ),
          Padding(padding: buttonPadding),
          TextButton(
            onTap: () {
              nav.openViewJourneysScreenWithNewDevice(context);
            },
            label: "I'M ON A NEW DEVICE",
          ),
          Padding(padding: buttonPadding),
        ],
      ),
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          top,
          bottom,
        ],
      ),
      backgroundColor: baseColors['dark'],
    );
  }
}
