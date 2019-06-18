import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class ShortTextInputFormElement extends StatelessWidget {
  ShortTextInputFormElement({
    @required this.textController,
    @required this.label,
    @required this.hint,
    // ignore: avoid_init_to_null
    this.maxLength = null,
    Key key,
    this.keyboardType,
    this.capitalisation = TextCapitalization.words,
    @required this.callback,
  }) : super(key: key);

  final TextEditingController textController;
  final TextInputType keyboardType;
  final TextCapitalization capitalisation;

  final SubmitCallback callback;

  final String label;
  final String hint;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return ShortTextInput(
          controller: textController,
          keyboardType: keyboardType,
          maxLength: maxLength,
          capitalisation: capitalisation,
          hint: hint,
          label: label,
          focus: focus,
          callback: submitCallback,
        );
      },
      onSubmitCallback: callback,
      fieldKey: key,
    );
  }
}
