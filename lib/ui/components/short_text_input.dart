import 'package:auto_size_text/auto_size_text.dart';
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
    this.keyboardType,
    @required this.capitalisation,
    this.validator,
  }) : super(key: key);

  final int maxLength;
  final String hint;
  final String label;
  final FocusNode focus;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextCapitalization capitalisation;
  final SubmitCallback callback;
  final FormFieldValidator<String> validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final underline = UnderlineInputBorder(
      borderSide: BorderSide(color: theme.cardColor),
    );
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          AutoSizeText(
            label,
            style: Theme.of(context).primaryTextTheme.headline,
            textScaleFactor: 0.8,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              textCapitalization: capitalisation,
              autofocus: true,
              maxLength: maxLength,
              style: theme.primaryTextTheme.title,
              cursorColor: theme.backgroundColor,
              decoration: InputDecoration(
                hintText: hint,
                focusedBorder: underline,
                enabledBorder: underline,
                labelStyle: theme.primaryTextTheme.title,
                hintStyle: hintStyle,
                helperStyle: hintStyle,
              ),
              focusNode: focus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: callback,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
