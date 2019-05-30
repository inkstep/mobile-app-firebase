import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class DepositQuestion extends StatelessWidget {
  const DepositQuestion({Key key, this.controller, this.autoScrollDuration})
      : super(key: key);

  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      label: 'Are you happy to leave a deposit?',
      hint: 'Yes!',
      duration: autoScrollDuration,
    );
  }
}