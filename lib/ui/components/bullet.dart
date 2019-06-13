import 'package:flutter/material.dart';

class Bullet extends StatelessWidget{
  const Bullet({Key key, this.color}) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).cardColor,
        shape: BoxShape.circle,
      ),
    );
  }
}