import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class SizingQuestion extends StatelessWidget {
  const SizingQuestion({Key key, this.controller,
    this.autoScrollDuration, this.func}) : super(key: key);

  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      Key('sizing'),
      label: 'How big would you like your tattoo to be?(cm)',
      hint: '7x3',
      duration: autoScrollDuration,
      func: func,
    );
  }
}
