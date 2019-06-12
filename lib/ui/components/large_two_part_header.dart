import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LargeTwoPartHeader extends StatelessWidget {
  LargeTwoPartHeader({
    Key key,
    @required this.largeText,
    @required this.name,
    this.taskStatus,
    this.dropShadow
  }) : super(key: key);

  final String largeText;
  final String name;
  final int taskStatus;
  final List<Shadow> dropShadow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          largeText,
          style: Theme
              .of(context)
              .textTheme
              .title
              .copyWith(color: Colors.white.withOpacity(0.7))
              .copyWith(shadows: dropShadow),
        ),
        if (name != null)
          Container(
            child: Text(
              name,
              style: Theme
                  .of(context)
                  .textTheme
                  .headline
                  .copyWith(shadows: dropShadow),
            ),
          ),
        if (taskStatus != null)
          Text(
              'You have ' + taskStatus.toString() + ' journey tasks to complete',
              style:
              Theme
                  .of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Colors.white.withOpacity(0.7))
                  .copyWith(shadows: dropShadow)
          ),
        if (taskStatus != null)
          Container(
            height: 16.0,
          )
      ],
    );
  }
}
