import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/ui/components/alert_dialog.dart';
import 'package:intl/intl.dart';

class QuoteDialog extends StatelessWidget {
  const QuoteDialog({
    Key key,
    @required this.artistName,
    @required this.stage,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final QuoteReceived stage;
  final String artistName;
  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  @override
  Widget build(BuildContext context) {
    return RoundedAlertDialog(
      title: null,
      child: Column(
        children: <Widget>[
          Text(
            'Hey! ${artistName.split(' ').first} wants to do your tattoo! They think this is a fair estimate.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              (stage.quote.start != stage.quote.end)
                  ? '£${stage.quote.start}-£${stage.quote.end}.'
                  : '£${stage.quote.start}.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Text(
            'You happy with this?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
      dismiss: SentimentRow(onAcceptance: onAcceptance, onDenial: onDenial),
    );
  }
}

class DateDialog extends StatelessWidget {
  const DateDialog({
    Key key,
    @required this.artistName,
    @required this.stage,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final AppointmentOfferReceived stage;
  final String artistName;
  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  @override
  Widget build(BuildContext context) {
    return RoundedAlertDialog(
      title: null,
      child: Column(
        children: <Widget>[
          Text(
            'Hey! ${artistName.split(' ').first} is excited to do your appointment:',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      DateFormat.E().format(stage.appointmentDate),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Text(
                      DateFormat.d().format(stage.appointmentDate),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                    Text(
                      DateFormat.LLLL().format(stage.appointmentDate),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Theme.of(context).cardColor,
                  width: 20,
                  indent: 3.0,
                ),
                Expanded(
                  child: Text(
                    DateFormat.jm().format(stage.appointmentDate),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
              ],
            ),
          ),
          Text(
            'You happy with this?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
      dismiss: SentimentRow(onAcceptance: onAcceptance, onDenial: onDenial),
    );
  }
}

class SentimentRow extends StatelessWidget {
  const SentimentRow({
    Key key,
    @required this.onAcceptance,
    @required this.onDenial,
  }) : super(key: key);

  final VoidCallback onAcceptance;
  final VoidCallback onDenial;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SentimentButton(
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
        SentimentButton(
          onTap: onDenial,
          icon: Icons.sentiment_dissatisfied,
          accentColor: Colors.red,
        ),
      ],
    );
  }
}

class SentimentButton extends StatelessWidget {
  const SentimentButton({
    Key key,
    @required this.onTap,
    @required this.icon,
    @required this.accentColor,
  }) : super(key: key);

  final VoidCallback onTap;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: accentColor,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          icon,
          size: 40.0,
          color: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
