import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/form_element_builder.dart';

// ignore: must_be_immutable
class BinaryInput extends StatelessWidget {
  BinaryInput({
    @required this.controller,
    @required this.callback,
    @required this.label,
    Key key,
    @required this.selection,
  }) : super(key: key);

  final SubmitCallback callback;
  final PageController controller;

  final String label;
  final String selection;

  VoidCallback onPressYes = () {print('foo');};
  VoidCallback onPressNo = () {print('bar');};

  @override
  Widget build(BuildContext context) {
    print('Printing current deposit value:');
    print(selection);
    print('Deposit value printed');
    if (selection == '1') {
      onPressYes = null;
    } else if (selection == '0') {
      onPressNo = null;
    }
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
                  _buildButton(context, true, onPressYes == null
                      ? onPressYes
                      : () {submitCallback('1');},),
                  _buildButton(context, false, onPressNo == null
                      ? onPressNo
                      : () {submitCallback('0');},),
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
    );
  }

  Widget _buildButton(BuildContext context, bool left, VoidCallback response) {
    final Radius r = Radius.circular(10);
    return FlatButton(
      padding: EdgeInsets.all(20),
      child: Text(left ? 'Yes' : 'No'),
      onPressed: response,
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
