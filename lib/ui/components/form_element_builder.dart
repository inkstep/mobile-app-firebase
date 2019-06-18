import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';

typedef ElementBuilder = Widget Function(
    BuildContext context, FocusNode focus, SubmitCallback onSubmit);

typedef SubmitCallback = void Function(String);
typedef BoolCallback = void Function(bool);

class FormElementBuilder extends StatelessWidget {
  FormElementBuilder({
    @required this.builder,
    this.scroll = true,
    this.fieldKey,
    this.duration = 500,
    @required this.onSubmitCallback,
  });

  final SubmitCallback onSubmitCallback;

  final Key fieldKey;
  final int duration;
  final bool scroll;
  final FocusNode focus = FocusNode();
  final ElementBuilder builder;

  final EdgeInsets kPadding = const EdgeInsets.all(20);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      child: Center(child: builder(context, focus, _attachFocusNext(onSubmitCallback))),
    );
  }

  SubmitCallback _attachFocusNext(SubmitCallback func) {
    return (textBoxValue) {
      func(textBoxValue);
      focus.unfocus();
    };
  }
}
