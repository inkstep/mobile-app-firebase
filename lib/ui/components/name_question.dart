import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class NameQ extends StatelessWidget {
  const NameQ({Key key, this.controller, this.textController,
    this.autoScrollDuration}) : super(key: key);

  final PageController controller;
  final TextEditingController textController;
  final int autoScrollDuration;
  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      label: 'What do your friends call you?',
      hint: 'Natasha',
      duration: autoScrollDuration,
    );
  }
}