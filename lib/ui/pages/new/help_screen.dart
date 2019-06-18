import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:speech_bubble/speech_bubble.dart';

class HelpDialog extends StatelessWidget {
  const HelpDialog({Key key, @required this.navigator, @required this.help}) : super(key: key);

  final InfoNavigator navigator;
  final String help;

  @override
  Widget build(BuildContext context) {
    return SpeechBubble(
      child: AutoSizeText(help, style: Theme.of(context).primaryTextTheme.subtitle),
      borderRadius: 10,
    );
  }
}
