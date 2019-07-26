import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

class BinaryInput extends StatelessWidget {
  const BinaryInput({
    @required this.callback,
    @required this.label,
    @required this.currentState,
    Key key,
  }) : super(key: key);

  final SubmitCallback callback;
  final buttonState currentState;

  final String label;

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
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headline,
                textScaleFactor: 0.8,
              ),
              flex: 5,
            ),
            Spacer(flex: 2),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildButton(context, true, () {
                    submitCallback('true');
                  }, currentState != buttonState.True),
                  _buildButton(context, false, () {
                    submitCallback('false');
                  }, currentState != buttonState.False),
                ],
              ),
              flex: 20,
            ),
          ],
        );
      },
      onSubmitCallback: callback,
      fieldKey: key,
      scroll: false,
    );
  }

  Widget _buildButton(BuildContext context, bool left, VoidCallback response, bool enabled) {
    final Radius r = Radius.circular(10);
    return FlatButton(
      padding: EdgeInsets.all(20),
      child: Text(
        left ? 'Yes' : 'No',
        style: Theme.of(context).primaryTextTheme.subtitle,
      ),
      onPressed: enabled ? response : null,
      disabledColor: left ? Colors.green : Theme.of(context).accentColor,
      color: left ? Theme.of(context).disabledColor : Theme.of(context).primaryColorDark,
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
