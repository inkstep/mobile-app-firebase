import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/bullet.dart';

class BulletElement extends StatelessWidget {
  const BulletElement(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
          child: Bullet(),
        ),
        Flexible(
          child: Text(
            text,
            style:  Theme.of(context).textTheme.body1,
          ),
        ),
      ],
    );
  }
}
