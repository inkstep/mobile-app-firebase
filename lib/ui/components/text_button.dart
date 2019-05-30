import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';

class TextButton extends StatelessWidget {
  TextButton({
    this.onTap,
    Key key,
  }) : super(key: key);

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "I'M ON A NEW DEVICE",
        style: TextStyle(
          color: baseColors['light'],
          fontSize: 15.0,
          fontFamily: 'Signika',
        ),
      ),
    );
  }
}
