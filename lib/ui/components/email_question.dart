import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class EmailQuestion extends StatelessWidget {
  const EmailQuestion({Key key, this.controller,
    this.autoScrollDuration, this.func}) : super(key: key);

  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      Key('email'),
      label: 'What is your email address?',
      hint: 'example@inkstep.com',
      duration: autoScrollDuration,
      func: func,
    );
  }
}
