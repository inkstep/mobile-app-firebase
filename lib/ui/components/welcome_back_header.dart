import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeBackHeader extends StatelessWidget {
  const WelcomeBackHeader({
    Key key,
    @required this.name,
    @required this.tasksToComplete,
  }) : super(key: key);

  final String name;
  final int tasksToComplete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0, left: 56.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Welcome back,',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Container(height: 16.0),
          Text(
            'You have ' + tasksToComplete.toString() +
                ' journey tasks to complete',
            style: Theme.of(context)
                .textTheme
                .body1
                .copyWith(color: Colors.white.withOpacity(0.7)),
          ),
          Container(
            height: 16.0,
          )
        ],
      ),
    );
  }
}
