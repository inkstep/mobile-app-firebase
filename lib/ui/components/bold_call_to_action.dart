import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BoldCallToAction extends StatelessWidget {
  BoldCallToAction({
    @required this.onTap,
    @required this.label,
    @required this.color,
    @required this.textColor,
    Key key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String label;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onTap,
      elevation: 15.0,
      color: color,
      textColor: textColor,
      padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: AutoSizeText(
        label,
        style: TextStyle(fontSize: 20, fontFamily: 'Signika'),
      ),
    );
  }
}
