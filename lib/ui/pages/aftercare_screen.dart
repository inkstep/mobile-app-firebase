import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/advice_dialog.dart';

class AfterCareScreen extends StatelessWidget {
  const AfterCareScreen({Key key, @required this.bookedTime}) : super(key: key);

  final DateTime bookedTime;

  List<Widget> adviceWidgets() {
    final List<AdviceDialog> advice = <AdviceDialog>[
      AdviceDialog(
        timeString: '2 hours',
        timeOffset: DateTime(0, 0, 0, 2),
        advice: const <String>['Leave in plastic wrap', 'Only remove after 2 hours'],
      ),
      AdviceDialog(
        timeString: 'week',
        timeOffset: DateTime(0, 0, 7),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area 3 times a day',
          'Apply cream every 8 hours'
        ],
      ),
      AdviceDialog(
        timeString: 'month',
        timeOffset: DateTime(0, 1),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area once a day',
        ],
      ),
    ];

    final DateTime curTime = DateTime.now();

    for (AdviceDialog adviceDialog in advice) {
      final Duration timeTo = bookedTime.difference(curTime);

      final Duration adviceDuration = adviceDialog.timeOffset.difference(DateTime(0));

      if (timeTo.compareTo(adviceDuration) < -1) {
        advice.remove(adviceDialog);
      }
    }

    return advice;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> advice = adviceWidgets();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Turn On Aftercare Notifications',
              style: TextStyle(color: Theme.of(context).primaryColorDark)),
          backgroundColor: Colors.white,
          onPressed: () {
            print('not yet implemented');
          }),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
          title: Text(
        'Aftercare',
        textScaleFactor: 1.5,
      )),
      body: ListView(
        children: advice +
          [Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Text(
              'Do not exfoliate your tattoo until it has fully healed.',
              textScaleFactor: 1.2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
