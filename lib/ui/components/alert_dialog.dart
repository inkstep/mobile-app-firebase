import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedAlertDialog extends StatelessWidget {
  const RoundedAlertDialog({
    this.title,
    @required this.child,
    this.dismiss,
  });

  final String title;
  final Widget child;
  final Widget dismiss;

  @override
  Widget build(BuildContext context) {
    // If text is given, add button
    final Widget defaultDismiss = RaisedButton(
      color: Colors.white,
      elevation: 15.0,
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        'Ok',
        style: TextStyle(fontSize: 20, fontFamily: 'Signika', color: Colors.black),
      ),
      onPressed: () => Navigator.pop(context),
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18.0))),
      title: title != null
          ? Text(
              title,
              textAlign: TextAlign.center,
            )
          : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (child != null) child,
          if (dismiss != null) SizedBox(height: 20),
          dismiss ?? defaultDismiss,
        ],
      ),
    );
  }
}
