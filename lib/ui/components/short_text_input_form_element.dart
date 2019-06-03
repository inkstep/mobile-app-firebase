import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class ShortTextInputFormElement extends StatelessWidget {
  ShortTextInputFormElement({
    @required this.controller,
    @required this.textController,
    @required this.label,
    @required this.hint,
    this.input,
    // ignore: avoid_init_to_null
    this.maxLength = null,
    Key key,
  }) : super(key: key);

  final PageController controller;
  final TextEditingController textController;

  final String label;
  final String hint;
  final String input;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return
          ShortTextInput(
            controller: textController,
            maxLength: maxLength,
            hint: hint,
            label: label,
            focus: focus,
            callback: (term) {},
          );
      },
      onSubmitCallback: (term) {},
      controller: controller,
      fieldKey: key,
    );
  }
}

