import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSwitch extends StatefulWidget {

  const PlatformSwitch({Key key, this.initialValue, this.callback}) : super(key: key);

  final void Function(bool calue) callback;
  final bool initialValue;

  @override
  State<StatefulWidget> createState() => PlatformSwitchState(initialValue, callback);
}

class PlatformSwitchState extends State<PlatformSwitch> {

  PlatformSwitchState(this._value, this.callback);

  final void Function(bool calue) callback;

  bool _value;

  void _onChanged(bool value) {
    setState(() => _value = value);
    callback(value);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: _value,
        onChanged: _onChanged,
      );
    } else if (Platform.isIOS) {
      return Switch(
        value: _value,
        onChanged: _onChanged,
      );
    }

    return Switch.adaptive(
      value: _value,
      onChanged: _onChanged,
    );
  }
}
