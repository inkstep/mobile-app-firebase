import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(
      children: <Widget>[
        Spacer(),
        Expanded(
            flex: 7,
            child: Divider(
              color: Theme.of(context).primaryColor,
            )),
        Spacer(),
      ],
    ));
  }
}
