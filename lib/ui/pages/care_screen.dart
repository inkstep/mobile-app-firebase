import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/advice_snippet.dart';

class CareScreen extends StatelessWidget {
  const CareScreen({Key key, @required this.bookedTime}) : super(key: key);

  final DateTime bookedTime;

  static bool hasAdvice(DateTime bookedTime) {
    return adviceWidget(bookedTime) != null;
  }

  static Widget adviceWidget(DateTime bookedTime) {
    final List<AdviceSnippet> advice = <AdviceSnippet>[
      AdviceSnippet(
        timeString: 'For the day before',
        timeOffset: Duration(days: 1),
        preCare: true,
        advice: const <String>['No drinking alcohol'],
      ),
      AdviceSnippet(
        timeString: 'For the first 2 hours',
        timeOffset: Duration(hours: 2),
        advice: const <String>['Leave in plastic wrap', 'Only remove after 2 hours'],
      ),
      AdviceSnippet(
        timeString: 'For the first week',
        timeOffset: Duration(days: 7),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area 3 times a day',
          'Apply cream every 8 hours'
        ],
      ),
      AdviceSnippet(
        timeString: 'For the first month',
        timeOffset: Duration(days: 31),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area once a day',
        ],
      ),
    ];

    final DateTime curTime = DateTime.now();

    for (AdviceSnippet adviceDialog in advice) {
      DateTime adviceDate;

      if (adviceDialog.preCare) {
        adviceDate = bookedTime.subtract(adviceDialog.timeOffset);
      } else {
        adviceDate = bookedTime.add(adviceDialog.timeOffset);
      }

      if (curTime.isBefore(bookedTime)) {
        if (curTime.isAfter(adviceDate)) {
          return adviceDialog;
        }
      } else {
        if (curTime.isBefore(adviceDate)) {
          return adviceDialog;
        }
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final AdviceSnippet advice = adviceWidget(bookedTime);

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Turn On Care Notifications',
              style: TextStyle(color: Theme.of(context).primaryColorDark)),
          backgroundColor: Colors.white,
          onPressed: () {
            print('not yet implemented');
          }),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(
        'Care Advice',
        textScaleFactor: 1.5,
      )),
      body: advice,
    );
  }
}
