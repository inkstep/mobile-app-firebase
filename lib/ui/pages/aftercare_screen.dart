import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/advice_dialog.dart';

class AfterCareScreen extends StatelessWidget {
  const AfterCareScreen({Key key, @required this.bookedTime}) : super(key: key);

  final DateTime bookedTime;

  List<Widget> adviceWidgets() {
    final List<AdviceDialog> advice = <AdviceDialog>[
      AdviceDialog(
        timeString: '2 hours',
        timeOffset: DateTime(0, 0, 0, 2, 0, 0, 0, 0),
        advice: const <String>['Leave in plastic wrap', 'Only remove after 2 hours'],
      ),
      AdviceDialog(
        timeString: 'week',
        timeOffset: DateTime(0, 0, 7, 0, 0, 0, 0, 0),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area 3 times a day',
          'Apply cream every 8 hours'
        ],
      ),
      AdviceDialog(
        timeString: 'month',
        timeOffset: DateTime(0, 1, 0, 0, 0, 0, 0, 0),
        advice: const <String>[
          'Do not itch skin',
          'Moisturise tattoo area once a day',
        ],
      ),
    ];

    final DateTime curTime = DateTime.now();

    final List<AdviceDialog> filteredAdvice = [];

    for (AdviceDialog adviceDialog in advice) {
      final Duration timeTo = curTime.difference(bookedTime);

      print('Curtime: ' + curTime.toString());
      print('BookedTime: ' + bookedTime.toString());

      print('timeOffset: ' + adviceDialog.timeOffset.toString());

      print('Timeto: ' + timeTo.toString());

      final Duration adviceDuration = adviceDialog.timeOffset.difference(
          DateTime(0, 0, 0, 0, 0, 0, 0, 0)
      );

      print('AdviceDuration: ' + adviceDuration.toString());

      if (timeTo.compareTo(adviceDuration) < 0) {
        filteredAdvice.add(adviceDialog);
      }
    }

    return filteredAdvice;
  }

  @override
  Widget build(BuildContext context) {
    final List<AdviceDialog> advice = adviceWidgets();

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
        children: advice
      ),
    );
  }
}
