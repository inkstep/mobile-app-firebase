import 'package:flutter/material.dart';
import 'package:inkstep/theme.dart';

class SentimentRow extends StatelessWidget {
  const SentimentRow({
    Key key,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  Widget _buildSentimentButton(BuildContext context,
      {@required VoidCallback onTap, @required IconData icon, @required Color accentColor}) {
    return InkWell(
      onTap: onTap,
      splashColor: accentColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: smallBorderRadius,
        ),
        child: Icon(
          icon,
          size: 40.0,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _buildSentimentButton(
          context,
          onTap: onAcceptance,
          icon: Icons.sentiment_satisfied,
          accentColor: Colors.green,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'OR',
            style: Theme.of(context).textTheme.caption,
          ),
        ),
        _buildSentimentButton(
          context,
          onTap: onDenial,
          icon: Icons.sentiment_dissatisfied,
          accentColor: Colors.red,
        ),
      ],
    );
  }
}
