import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:inkstep/ui/components/binary_input.dart';
import 'package:inkstep/utils/info_navigator.dart';

import 'info_widget.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({
    Key key,
    @required this.navigator,
    this.deposit,
    this.callback,
  }) : super(key: key);

  final InfoNavigator navigator;
  final void Function(buttonState) callback;
  final String deposit;

  @override
  State<StatefulWidget> createState() => _DepositScreenState(navigator, deposit, callback);
}

class _DepositScreenState extends State<DepositScreen> {
  _DepositScreenState(this.navigator, String deposit, this.callback) {
    if (deposit == '') {
      this.deposit = buttonState.Unset;
    } else if (deposit == '1') {
      this.deposit = buttonState.True;
    } else if (deposit == '0') {
      this.deposit = buttonState.False;
    }
  }

  final InfoNavigator navigator;
  final void Function(buttonState) callback;
  buttonState deposit;

  @override
  Widget build(BuildContext context) {
    return DepositWidget(navigator, deposit, (buttonPressed) {
      setState(() {
        if (buttonPressed == 'true') {
          deposit = buttonState.True;
        } else {
          deposit = buttonState.False;
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return RoundedAlertDialog(
                title: 'Are you sure?',
                child: Text(
                  'Most artists require a deposit in order to secure you an '
                  'appointment. Don\'t worry, you won\'t have to pay this yet!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).primaryTextTheme.subtitle,
                ),
              );
            },
          );
        }
      });
    }, callback);
  }
}

class DepositWidget extends InfoWidget {
  DepositWidget(this.navigator, this.deposit, this.callback, this.updateCallback);

  final InfoNavigator navigator;
  final buttonState deposit;
  final void Function(String) callback;
  final void Function(buttonState) updateCallback;

  @override
  Widget getWidget(BuildContext context) {
    return BinaryInput(
        label: 'Are you willing to leave a deposit?', currentState: deposit, callback: callback);
  }

  @override
  InfoNavigator getNavigator() {
    return navigator;
  }

  @override
  void submitCallback() {
    updateCallback(deposit);
  }

  @override
  bool valid() {
    return deposit == buttonState.True;
  }


}
