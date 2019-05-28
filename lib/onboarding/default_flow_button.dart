import 'package:flutter/material.dart';

import '../theming.dart';

class DefaultFlowButton extends StatelessWidget {
  DefaultFlowButton({
    this.destination,
    Key key,
  }) : super(key: key);

  Widget destination;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push<dynamic>(context,
            MaterialPageRoute<dynamic>(builder: (context) => destination));
      },
      elevation: 15.0,
      color: Colors.white,
      textColor: darkColor,
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        "Let's get started!",
        style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
      ),
    );
  }
}
