import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inkstep/ui/components/large_two_part_header.dart';

class WelcomeBackScreen extends StatelessWidget {
  const WelcomeBackScreen({Key key, this.name, this.loading = false}) : super(key: key);

  final String name;
  final bool loading;

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
