import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:speech_bubble/speech_bubble.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({Key key, @required this.navigator, @required this.help}) : super(key: key);

  final InfoNavigator navigator;
  final List<String> help;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [for (String child in help) getBubble(child, context)]);
  }

  Widget getBubble(String child, BuildContext context) {
    return SpeechBubble(
      child: Text(
        child,
        style: Theme.of(context).accentTextTheme.subtitle,
      ),
      borderRadius: 10,
      color: Theme.of(context).cardColor,
    );
  }
}
