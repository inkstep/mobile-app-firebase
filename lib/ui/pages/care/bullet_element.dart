import 'package:flutter/material.dart';

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
          child: Container(
            height: 10.0,
            width: 10.0,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Flexible(
          child: Text(
            text,
            style:  Theme.of(context).textTheme.body2,
          ),
        ),
      ],
    );
  }
}
