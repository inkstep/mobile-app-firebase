import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  const RoundedAlertDialog({@required this.title, this.body, this.dismissButtonText});

  final String title;
  final String body;
  final String dismissButtonText;

  @override
  Widget build(BuildContext context) {
    // If text is given, add button
    Widget dismissButton;
    if (dismissButtonText != null) {
      dismissButton = RaisedButton(
        elevation: 15.0,
        padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        child: Text(dismissButtonText, style: TextStyle(
            fontSize: 20.0, fontFamily: 'Signika'),
        ), onPressed: () => Navigator.pop(context),
      );
    } else {
      dismissButton = Container();
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
      title: Text(
        title,
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          body == null ? Container() : Text(body, textAlign: TextAlign.center),
          dismissButton is Container ? Container() : SizedBox(height: 20),
          dismissButton,
        ],
      ),
    );
  }
}
