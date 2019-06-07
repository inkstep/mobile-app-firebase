import 'package:flutter/material.dart';
import 'package:inkstep/main.dart';

class TextButton extends StatelessWidget {
  TextButton({
    @required this.onTap,
    @required this.label,
    Key key,
  }) : super(key: key);

  final GestureTapCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          label,
          style: TextStyle(
            color: baseColors['light'],
            fontSize: 15.0,
            fontFamily: 'Signika',
          ),
        ),
      ),
    );
  }
}
