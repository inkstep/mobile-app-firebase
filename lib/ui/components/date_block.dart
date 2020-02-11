import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateBlock extends StatelessWidget {
  const DateBlock({
    Key key,
    @required this.date,
    this.onlyDate = false,
    this.scale,
  }) : super(key: key);

  final DateTime date;
  final bool onlyDate;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              DateFormat.E().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
              textScaleFactor: scale,
            ),
            Text(
              DateFormat.d().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title,
              textScaleFactor: scale,
            ),
            Text(
              DateFormat.LLLL().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
              textScaleFactor: scale,
            ),
          ],
        ),
        if (!onlyDate)
          VerticalDivider(
            color: Theme.of(context).cardColor,
            width: 20,
            indent: 3.0,
          ),
        if (!onlyDate)
          Expanded(
            child: Text(
              DateFormat.jm().format(date),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subtitle,
              textScaleFactor: scale,
            ),
          ),
      ],
    );
  }
}
