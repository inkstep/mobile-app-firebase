import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Center(
        child: SpinKitChasingDots(
          color: Theme.of(context).cardColor,
          size: 50.0,
        ),
      ),
    );
  }
}
