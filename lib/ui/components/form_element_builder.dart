import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/material.dart';

typedef ElementBuilder = Widget Function(
    BuildContext context, FocusNode focus, VoidCallback onSubmit);


class FormElementBuilder extends StatelessWidget {
  FormElementBuilder({
    @required this.builder,
    @required this.controller,
    this.fieldKey,
    this.duration = 500,
  });

  final PageController controller;
  final Key fieldKey;
  final int duration;
  final FocusNode focus = FocusNode();
  final ElementBuilder builder;

  final EdgeInsets kPadding = const EdgeInsets.all(30);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      child: Center(
          child: builder(context, focus, _focusNext())),
    );
  }

  VoidCallback _focusNext() => () {
    focus.unfocus();
    controller.nextPage(
        duration: Duration(milliseconds: duration), curve: Curves.ease);
  };
}
