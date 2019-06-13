import 'package:flutter/material.dart';

import 'bullet.dart';
import 'horizontal_divider.dart';

class AdviceSnippet extends StatelessWidget {
  const AdviceSnippet({
    Key key,
    @required this.timeString,
    @required this.advice,
    @required this.timeOffset,
    this.preCare = false,
  }) : super(key: key);

  final String timeString;
  final Duration timeOffset;
  final bool preCare;
  final List<String> advice;

  List<Widget> processAdvice(List<String> advice) {
    final List<Widget> processedAdvice = [];

    final Widget careText = Expanded(
      child: Text(
        preCare ? 'Precare' : 'Aftercare',
        textScaleFactor: 3,
      ),
    );

    processedAdvice.add(careText);

    final Widget timeWidget = Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            timeString,
            textScaleFactor: 1.5,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );

    processedAdvice.add(timeWidget);

    final Widget divWidget = HorizontalDivider(
      thickness: 4,
      percentage: 80,
    );

    processedAdvice.add(divWidget);

    for (String adviceString in advice) {
      final Text text = Text(
        adviceString,
        textAlign: TextAlign.left,
        textScaleFactor: 1.5,
      );

      final Widget expandedWidget = Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Bullet(),
              ),
              Spacer(),
              Expanded(
                flex: 10,
                child: text,
              )
            ],
          ));

      processedAdvice.add(expandedWidget);
    }

    final Widget spacerWidget = Spacer(flex: 2);

    processedAdvice.add(spacerWidget);

    return processedAdvice;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: processAdvice(advice),
      )
    );
  }
}
