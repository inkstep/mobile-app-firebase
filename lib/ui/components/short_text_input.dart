import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

class ShortTextInput extends StatelessWidget {
  ShortTextInput({
    @required this.controller,
    @required this.callback,
    @required this.label,
    @required this.hint,
    this.height = 100,
    Key key,
  }) : super(key: key);

  final SubmitCallback callback;
  final PageController controller;

  final String label;
  final String hint;
  final double height;

  final kCurve = Curves.ease;

  final nameFontSize = 40.0;
  final labelFontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        final theme = Theme.of(context);
        final underline = UnderlineInputBorder(
          borderSide: BorderSide(color: theme.backgroundColor),
        );
        return TextFormField(
          autofocus: true,
          maxLength: 16,
          style: theme.accentTextTheme.headline,
          cursorColor: theme.backgroundColor,
          decoration: InputDecoration(
            hintText: hint,
            labelText: label,
            focusedBorder: underline,
            enabledBorder: underline,
            labelStyle: theme.accentTextTheme.title,
            hintStyle: hintStyle,
            helperStyle: hintStyle,
          ),
          focusNode: focus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: submitCallback,
        );
      },
      onSubmitCallback: callback,
      controller: controller,
      fieldKey: key,
    );
  }
}
