import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';

class ShortTextInput extends StatelessWidget {
  ShortTextInput(this.formController, this.labelText, this.hintText,
      {this.height = 100});

  final PageController formController;
  final String labelText;
  final String hintText;
  final double height;
  final FocusNode focus = FocusNode();

  final kDuration = Duration(milliseconds: 500);
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
        decoration: BoxDecoration(
          color: baseColors['light'],
        ),
        padding: kPadding,
        child: Center(
          child: TextFormField(
            autofocus: true,
            key: Key('name'),
            style: TextStyle(color: baseColors['dark'], fontSize: nameFontSize),
            cursorColor: baseColors['dark'],
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
              focusedBorder: underlineBorder,
              enabledBorder: underlineBorder,
              labelStyle:
                  TextStyle(color: baseColors['dark'], fontSize: labelFontSize),
              hintStyle: hintStyle,
            ),
            focusNode: focus,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (term) {
              print('NAME: $term');
              focus.unfocus();
              formController.nextPage(duration: kDuration, curve: kCurve);
            },
          ),
        ));
  }
}
