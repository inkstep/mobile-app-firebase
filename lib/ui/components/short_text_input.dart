import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';

class ShortTextInput extends StatelessWidget {
  ShortTextInput(
    this.formController, {
    this.label,
    this.hint,
    this.duration = 500,
    this.height = 100,
    this.func
  });

  final void Function(String) func;
  final PageController formController;
  final String label;
  final String hint;
  final double height;
  final int duration;
  final FocusNode focus = FocusNode();

  final kCurve = Curves.ease;

  final nameFontSize = 40.0;
  final labelFontSize = 16.0;

  final InputBorder underlineBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: baseColors['dark'],
      style: BorderStyle.solid,
    ),
  );

  final EdgeInsets kPadding = const EdgeInsets.all(30);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: kPadding,
        child: Center(
          child: TextFormField(
            autofocus: true,
            key: Key('name'),
            style: TextStyle(color: baseColors['dark'], fontSize: nameFontSize),
            cursorColor: baseColors['dark'],
            decoration: InputDecoration(
              hintText: hint,
              labelText: label,
              focusedBorder: underlineBorder,
              enabledBorder: underlineBorder,
              labelStyle: TextStyle(color: baseColors['dark'], fontSize: labelFontSize),
              hintStyle: hintStyle,
            ),
            focusNode: focus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (term) {
              func(term);
              focus.unfocus();
              formController.nextPage(duration: Duration(milliseconds: duration), curve: kCurve);
            },
          ),
        ));
  }
}
