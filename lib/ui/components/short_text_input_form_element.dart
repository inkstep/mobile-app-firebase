import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';
import 'package:inkstep/ui/components/short_text_input.dart';

class ShortTextInputFormElement extends StatelessWidget {
  ShortTextInputFormElement({
    @required this.controller,
    @required this.textController,
    @required this.label,
    @required this.hint,
    // TODO(Felination): Remove onSubmitCallback once availability
    //  has been refactored
    //ignore: avoid_init_to_null
    this.onSubmitCallback = null,
    // ignore: avoid_init_to_null
    this.maxLength = null,
    Key key,
  }) : super(key: key);

  final PageController controller;
  final TextEditingController textController;

  // TODO(Felination): Remove after availability has been refactored
  final void Function(String) onSubmitCallback;
  // final void Function(String) callback = (_) {};

  final String label;
  final String hint;
  final int maxLength;

  @override
  Widget build(BuildContext context) {
    // TODO(Felination): Remove after availability has been refactored
    //  + make callback final
    final void Function(String) callback = onSubmitCallback == null ? (_) {} : onSubmitCallback;

    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return
          ShortTextInput(
            controller: textController,
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

