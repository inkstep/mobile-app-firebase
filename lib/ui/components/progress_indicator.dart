import 'package:flutter/material.dart';

class JourneyProgressIndicator extends StatelessWidget {
  const JourneyProgressIndicator({@required this.color, @required this.progress, this.style});

  final Color color;
  final int progress;
  final TextStyle style;

  double get _height => 3.0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Stack(
                children: [
                  Container(
                    height: _height,
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  AnimatedContainer(
                    height: _height,
                    width: (progress / 100) * constraints.maxWidth,
                    color: color,
                    duration: Duration(milliseconds: 300),
                  ),
                ],
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 8.0),
          child: Text(
            '$progress%',
            style: style ?? Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}
