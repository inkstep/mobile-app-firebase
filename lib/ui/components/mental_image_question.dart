import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/long_text_input.dart';

class MentalImageQuestion extends StatelessWidget {
  const MentalImageQuestion(
      {Key key, this.controller, this.autoScrollDuration, this.submitCallback})
      : super(key: key);

  final void Function(String) submitCallback;
  final PageController controller;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return LongTextInput(
      controller: controller,
      label: 'Describe the image in your head of the tattoo you want?',
      hint: 'A sleeping deer protecting a crown with stars splayed behind it',
      callback: submitCallback,
    );
  }
}
