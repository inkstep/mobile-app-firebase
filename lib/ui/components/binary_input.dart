import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

// ignore: must_be_immutable
class BinaryInput extends StatelessWidget {
  BinaryInput({
    @required this.controller,
    @required this.callback,
    @required this.label,
    @required this.currentState,
    Key key,
  }) : super(key: key);

  final SubmitCallback callback;
  final PageController controller;
  final buttonState currentState;

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return FormElementBuilder(
      builder: (context, focus, submitCallback) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                label,
                style: theme.accentTextTheme.title,
              ),
              flex: 5,
            ),
            Spacer(flex: 1),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildButton(context, true, () {submitCallback('true');}, currentState!=buttonState.True),
                  _buildButton(context, false, () {submitCallback('false');}, currentState!=buttonState.False),
                ],
              ),
              flex: 20,
            ),
          ],
        );
      },
      onSubmitCallback: callback,
      controller: controller,
      fieldKey: key,
      scroll: false,
    );
  }

  Widget _buildButton(BuildContext context, bool left, VoidCallback response, bool enabled) {
    final Radius r = Radius.circular(10);
    return FlatButton(
      padding: EdgeInsets.all(20),
      child: Text(left ? 'Yes' : 'No'),
      onPressed: enabled ? response : null,
      disabledColor: Theme.of(context).primaryColorDark,
      color: left
          ? Theme.of(context).accentColor
          : Theme.of(context).backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: left
            ? BorderRadius.horizontal(
                left: r,
              )
            : BorderRadius.horizontal(
                right: r,
              ),
      ),
    );
  }
}

enum buttonState {
  True,
  False,
  Unset,
}