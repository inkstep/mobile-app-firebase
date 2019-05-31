import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class DepositQuestion extends StatelessWidget {
  const DepositQuestion(
      {Key key, this.controller, this.autoScrollDuration, this.submitCallback})
      : super(key: key);

  final void Function(String) submitCallback;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller: controller,
      label: 'Are you happy to leave a deposit?',
      hint: 'Yes!',
      callback: submitCallback,
    );
  }
}
