import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class NameQ extends StatelessWidget {
  const NameQ({Key key, this.func, this.controller,
    this.autoScrollDuration,}) : super(key: key);


  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;
  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      func: func,
      label: 'What do your friends call you?',
      hint: 'Natasha',
      duration: autoScrollDuration,
    );
  }
}