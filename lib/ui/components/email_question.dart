import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class EmailQuestion extends StatelessWidget {
  const EmailQuestion(
      {Key key, this.controller, this.autoScrollDuration, this.submitCallback})
      : super(key: key);

  final void Function(String) submitCallback;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller: controller,
      label: 'What is your email address?',
      hint: 'example@inkstep.com',
      callback: submitCallback,
    );
  }
}
