import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class PositionQuestion extends StatelessWidget {
  const PositionQuestion(
      {Key key, this.controller, this.autoScrollDuration, this.submitCallback})
      : super(key: key);

  final void Function(String) submitCallback;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller: controller,
      label: 'Where on your body do you want the tattoo',
      hint: 'Lower left forearm',
      callback: submitCallback,
    );
  }
}
