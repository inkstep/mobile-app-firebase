import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'form_element_builder.dart';

class DropdownMenu extends StatelessWidget {

  const DropdownMenu({
    @required this.hintText,
    @required this.items,
    @required this.callback,
    @required this.controller,
    Key key}) : super (key: key);

  final String hintText;
  final List<String> items;
  final ValueChanged<String> callback;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return DropdownButton<String>(
          value: null,
          hint: Text(
            hintText,
            style: Theme.of(context).accentTextTheme.subhead,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: callback,
          style: Theme.of(context).textTheme.subhead,
          iconEnabledColor:
          Theme.of(context).colorScheme.background,
        );
      },
      onSubmitCallback: callback,
      controller: controller,
    );
  }
}
