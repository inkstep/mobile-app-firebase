import 'package:flutter/cupertino.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class NameQuestion extends StatelessWidget {
  const NameQuestion({
    Key key,
    this.func,
    this.controller,
  }) : super(key: key);

  final SubmitCallback func;
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller: controller,
      callback: func,
      label: 'What do your friends call you?',
      hint: 'Natasha',
    );
  }
}
