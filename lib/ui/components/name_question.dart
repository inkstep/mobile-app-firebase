import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class NameQ extends StatelessWidget {
  final PageController controller;
  final int autoScrollDuration;

  const NameQ({Key key, this.controller, this.autoScrollDuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      label: 'What do your friends call you?',
      hint: 'Natasha',
      duration: autoScrollDuration,
    );
  }
}