import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import 'form_element_builder.dart';

class ShortTextInput extends StatelessWidget {
  const ShortTextInput({
    Key key,
    @required this.maxLength,
    @required this.hint,
    @required this.label,
    @required this.controller,
    this.focus,
    @required this.callback,
  }) : super(key: key);

  final int maxLength;
  final String hint;
  final String label;
  final FocusNode focus;
  final TextEditingController controller;
  final SubmitCallback callback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final underline = UnderlineInputBorder(
      borderSide: BorderSide(color: theme.backgroundColor),
    );
    return TextFormField(
      controller: controller,
      autofocus: true,
      maxLength: maxLength,
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
      onFieldSubmitted: callback,
    );
  }
}
