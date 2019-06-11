import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeTwoPartHeader extends StatelessWidget {
  const LargeTwoPartHeader({
    Key key,
    @required this.largeText,
    @required this.name,
    this.taskStatus,
  }) : super(key: key);

  final String largeText;
  final String name;
  final int taskStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            largeText,
            style: Theme.of(context).textTheme.title.copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          if (name != null)
            Container(
              child: Text(
                name,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          if (taskStatus != null)
            Text(
              'You have ' + taskStatus.toString() + ' journey tasks to complete',
              style:
                  Theme.of(context).textTheme.body1.copyWith(color: Colors.white.withOpacity(0.7)),
            ),
          if (taskStatus != null)
            Container(
              height: 16.0,
            )
        ],
      ),
    );
  }
}
