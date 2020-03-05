import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_element_builder.dart';

class LongTextInput extends StatelessWidget {
  const LongTextInput({
    Key key,
    @required this.hint,
    this.focus,
    this.controller,
    this.callback,
  }) : super(key: key);

  final String hint;
  final FocusNode focus;
  final TextEditingController controller;
  final SubmitCallback callback;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      maxLines: 5,
      style: Theme.of(context).primaryTextTheme.body1,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            Theme.of(context).primaryTextTheme.body1.copyWith(color: Colors.white.withOpacity(0.8)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).cardColor)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).cardColor,
          ),
        ),
        fillColor: Colors.green,
      ),
      focusNode: focus,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: callback,
    );
  }
}
