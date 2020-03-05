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

  // TODO(mm): use fieldKey and scroll properly?
  final Key fieldKey;
  final bool scroll;
  final FocusNode focus = FocusNode();
  final ElementBuilder builder;
  final SubmitCallback onSubmitCallback;

  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
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
