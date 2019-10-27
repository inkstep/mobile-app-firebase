import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inkstep/ui/components/horizontal_divider.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';

class LandingScreen extends StatelessWidget {

  const LandingScreen({Key key, this.name}) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Column(
        children: <Widget>[
          Spacer(flex: 10),
          Center(
            child: LargeTwoPartHeader(
            largeText: 'Welcome back',
            name: name,
            ),
          ),
          Spacer(flex: 1),
          Spacer(flex: 6),
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
