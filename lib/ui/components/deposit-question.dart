import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class DepositQuestion extends StatelessWidget {
  const DepositQuestion({Key key, this.controller,
    this.autoScrollDuration, this.func}) : super(key: key);


  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      label: 'Are you happy to leave a deposit?',
      hint: 'Yes!',
      duration: autoScrollDuration,
      func: func,
    );
  }
}