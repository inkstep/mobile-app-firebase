import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';

class BoldCallToAction extends StatelessWidget {
  BoldCallToAction({
    @required this.onTap,
    @required this.label,
    Key key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      elevation: 15.0,
      color: baseColors['light'],
      textColor: baseColors['dark'],
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        label,
        style: TextStyle(fontSize: 20.0, fontFamily: 'Signika'),
      ),
    );
  }
}
