import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class ShortTextInputFormElement extends StatelessWidget {
  ShortTextInputFormElement({
    @required this.controller,
    @required this.callback,
    @required this.label,
    @required this.hint,
    this.input,
    // ignore: avoid_init_to_null
    this.maxLength = null,
    Key key,
  }) : super(key: key);

  final SubmitCallback callback;
  final PageController controller;

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
            input: input,
            maxLength: maxLength,
            hint: hint,
            label: label,
            focus: focus,
            callback: submitCallback,
          );
      },
      onSubmitCallback: callback,
      controller: controller,
      fieldKey: key,
    );
  }
}

