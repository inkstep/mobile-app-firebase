import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

import 'long_text_input.dart';

class LongTextInputFormElement extends StatelessWidget {
  LongTextInputFormElement({
    @required this.textController,
    @required this.label,
    @required this.hint,
    @required this.callback,
    Key key,
  }) : super(key: key);

  final TextEditingController textController;
  final SubmitCallback callback;

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Describe your concept',
              style: Theme.of(context).primaryTextTheme.headline,
              textScaleFactor: 0.8,
            ),
            Spacer(),
            Text(
              label,
              style: Theme.of(context).primaryTextTheme.subhead,
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Flexible(
              child: LongTextInput(
                hint: hint,
                focus: focus,
                controller: textController,
                callback: submitCallback,
              ),
              flex: 20,
            ),
            Spacer(),
            Text(
              'You\'ll get to add some photos to show them in a minute.'
            ),
          ],
        );
      },
      onSubmitCallback: callback,
      fieldKey: key,
    );
  }
}


