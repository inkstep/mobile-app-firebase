import 'package:flutter/material.dart';

import '../main.dart';

class ShortTextInput extends StatelessWidget {
  ShortTextInput(this.formController, this.labelText,
      this.hintText, {this.height=100});

  final PageController formController;
  final String labelText;
  final String hintText;
  final double height;
  final FocusNode focus = FocusNode();

  final kDuration = Duration(milliseconds: 300);
  final kCurve = Curves.ease;

  final nameFontSize = 40.0;
  final labelFontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    final underlineBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: darkColor, style: BorderStyle.solid));
    return Container(
      width: 100,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.white,
      ),
      padding: EdgeInsets.all(30),
      child: Center(
        child:
        TextFormField(
          autofocus: true,
          key: Key('name'),
          style: TextStyle(color: darkColor, fontSize: nameFontSize),
          cursorColor: darkColor,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            focusedBorder: underlineBorder,
            enabledBorder: underlineBorder,
            labelStyle: TextStyle(color: darkColor, fontSize: labelFontSize),
            hintStyle: hintStyle,
          ),
          focusNode: focus,
          textInputAction: TextInputAction.next,
        ),
      )
    );
  }
}