import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformSwitch extends StatefulWidget {

  const PlatformSwitch({Key key, this.callback}) : super(key: key);

  final void Function(bool calue) callback;

  @override
  State<StatefulWidget> createState() => PlatformSwitchState(callback);
}

class PlatformSwitchState extends State<PlatformSwitch> {

  PlatformSwitchState(this.callback);

  final void Function(bool calue) callback;

  bool _value = false;

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
