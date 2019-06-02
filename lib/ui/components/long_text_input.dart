import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

class LongTextInput extends StatelessWidget {
  LongTextInput({
    @required this.controller,
    @required this.callback,
    @required this.label,
    @required this.hint,
    Key key,
  }) : super(key: key);

  final SubmitCallback callback;
  final PageController controller;

  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                label,
                style: Theme.of(context).accentTextTheme.subhead,
              ),
              flex: 5,
            ),
            Spacer(flex: 1),
            Flexible(
              child: TextFormField(
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
                onFieldSubmitted: submitCallback,
              ),
              flex: 20,
            ),
          ],
        );
      },
      onSubmitCallback: callback,
      controller: controller,
      fieldKey: key,
    );
  }
}
