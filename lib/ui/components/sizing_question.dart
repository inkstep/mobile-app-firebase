import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class SizingQuestion extends StatelessWidget {
  const SizingQuestion({Key key, this.controller, this.textController,
    this.autoScrollDuration}) : super(key: key);

  final PageController controller;
  final TextEditingController textController;
  final int autoScrollDuration;

  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      label: 'How big would you like your tattoo to be?(cm)',
      hint: '7x3',
      duration: autoScrollDuration,
    );
  }
}