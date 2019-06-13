import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key key,
    this.thickness = 1,
    this.percentage = 70,
    this.alignment,
    this.padding,
    this.color,
  }) : super(key: key);

  final double thickness;
  final int percentage;
  final MainAxisAlignment alignment;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final MainAxisAlignment actualAlignment = alignment ?? MainAxisAlignment.center;
    final int spacerFlex = actualAlignment == MainAxisAlignment.center
        ? (100 - percentage) ~/ 2
        : (100 - percentage);

    return Expanded(
        child: Row(
      children: <Widget>[
        if (actualAlignment == MainAxisAlignment.end || actualAlignment == MainAxisAlignment.center)
          Spacer(flex: spacerFlex),
        Expanded(
          flex: percentage,
          child: Center(
            child: Container(
              height: 0.0,
              margin: padding,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: color ?? Theme.of(context).dividerColor,
                    width: thickness,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (actualAlignment == MainAxisAlignment.start ||
            actualAlignment == MainAxisAlignment.center)
          Spacer(flex: spacerFlex),
      ],
    ));
  }
}
