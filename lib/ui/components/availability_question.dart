import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class AvailabilityQuestion extends StatelessWidget {
  const AvailabilityQuestion(
      {Key key, this.controller, this.autoScrollDuration, this.submitCallback})
      : super(key: key);

  final void Function(String) submitCallback;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller: controller,
      label: 'What days of the week are you normally available?',
      hint: 'Mondays, Tuesdays and Saturdays',
      callback: submitCallback,
    );
  }
}
