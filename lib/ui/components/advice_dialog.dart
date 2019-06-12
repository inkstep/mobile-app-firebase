import 'package:flutter/material.dart';

class AdviceDialog extends StatelessWidget {
  const AdviceDialog({Key key,
    @required this.timeString,
    @required this.advice,
    @required this.timeOffset,
  }) : super(key: key);

  final String timeString;
  final DateTime timeOffset;
  final List<String> advice;

  @override
  Widget build(BuildContext context) {
    final List<Text> adviceText = advice.map((text) => Text(
      text,
      textAlign: TextAlign.center,
    )).toList();

    final List<Text> dialogWidgets = [Text(
      'For the first ' + timeString,
      textScaleFactor: 1.5,
      textAlign: TextAlign.center,
    )] + adviceText;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: dialogWidgets,
      ),
    );
  }
}