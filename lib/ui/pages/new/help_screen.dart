import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/utils/info_navigator.dart';
import 'package:speech_bubble/speech_bubble.dart';

import 'info_widget.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key key, @required this.navigator, @required this.help}) : super(key: key);

  final InfoNavigator navigator;
  final String help;

  @override
  Widget build(BuildContext context) {
    return HelpScreenWidget(navigator, help);
  }
}

class HelpScreenWidget extends InfoWidget {
  HelpScreenWidget(this.navigator, this.help);

  final InfoNavigator navigator;
  final String help;

  @override
  InfoNavigator getNavigator() {
    return navigator;
  }

  @override
  Widget getWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SpeechBubble(child: AutoSizeText(help, style: Theme.of(context).primaryTextTheme
          .subtitle), borderRadius: 10,),
    );
  }

  @override
  void submitCallback() {
    return;
  }

  @override
  bool valid() {
    return true;
  }
}
