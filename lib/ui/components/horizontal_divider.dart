import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key key,
    this.thickness,
    this.percentage,
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
    final int actualPercentage = percentage ?? 70;
    final int spacerFlex = actualAlignment == MainAxisAlignment.center
        ? (100 - actualPercentage) ~/ 2
        : (100 - actualPercentage);

    return Expanded(
        child: Row(
      children: <Widget>[
        if (actualAlignment == MainAxisAlignment.end || actualAlignment == MainAxisAlignment.center)
          Spacer(flex: spacerFlex),
        Expanded(
          flex: actualPercentage,
          child: Center(
            child: Container(
              height: 0.0,
              margin: padding,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: color ?? Theme.of(context).dividerColor,
                    width: thickness ?? 1,
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
