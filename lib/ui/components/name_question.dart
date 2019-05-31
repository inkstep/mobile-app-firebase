import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart' as prefix0;
import 'package:inkstep/ui/components/short_text_input.dart';

class NameQ extends StatelessWidget {
  const NameQ({Key key, this.func, this.controller,
    this.autoScrollDuration, this.name}) : super(key: key);

  final String name;
  final void Function(String) func;
  final PageController controller;
  final int autoScrollDuration;
  @override
  Widget build(BuildContext context) {
    return ShortTextInput(
      controller,
      Key('name'),
      func: func,
      label: 'What do your friends call you?',
      hint: 'Natasha',
      input: name,
      duration: autoScrollDuration,
    );
  }
}
