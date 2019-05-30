import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class MentalImageQuestion extends StatelessWidget {
  const MentalImageQuestion({Key key, this.controller,
    this.autoScrollDuration, this.func}) : super(key: key);

  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      Key('visualisation'),
      label: 'Describe the image in your head of the tattoo you want?',
      hint: 'I picture a fierce fiery red dragon coiled around my neck',
      duration: autoScrollDuration,
      func: func,
    );
  }
}
