import 'package:flutter/material.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';

class QuoteDialog extends StatelessWidget {
  const QuoteDialog({
    Key key,
    @required this.card,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final CardModel card;
  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  @override
  Widget build(BuildContext context) {
    return RoundedAlertDialog(
      title: null,
      child: Column(
        children: <Widget>[
          Text(
            'Hey! ${card.artistName.split(' ').first} wants to do your tattoo! They think this is a fair estimate.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Text(
            '£${card.quote.start}-£${card.quote.end}.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline,
          ),
          Text(
            'You happy with this?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
      dismiss: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: onAcceptance,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.sentiment_satisfied,
                size: 40.0,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          GestureDetector(
            onTap: onDenial,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.sentiment_dissatisfied,
                size: 40.0,
                color: Theme.of(context).backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
