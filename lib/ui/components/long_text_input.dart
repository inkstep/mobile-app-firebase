import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_element_builder.dart';

class LongTextInput extends StatelessWidget {
  const LongTextInput({
    Key key,
    @required this.hint,
    this.focus,
    this.callback,
  }) : super(key: key);

  final String hint;
  final FocusNode focus;
  final SubmitCallback callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      keyboardType: TextInputType.multiline,
      maxLines: 5,
      style: Theme.of(context).accentTextTheme.body1,
      cursorColor: Theme.of(context).backgroundColor,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).accentTextTheme.body1,
        enabledBorder: OutlineInputBorder(borderSide: BorderSide()),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      focusNode: focus,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: callback,
    );
  }
}
