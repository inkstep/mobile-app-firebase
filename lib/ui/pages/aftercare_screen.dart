import 'package:flutter/material.dart';

class AfterCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Turn On Aftercare Notifications'),
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
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: const <Widget>[
                Text(
                  'For the first 2 hours:',
                  textScaleFactor: 1.5,
                ),
                Text(
                  'Leave in plastic wrap',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Only remove after 2 hours',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: const <Widget>[
                Text(
                  'For the first week:',
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Do not itch skin',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Moisturise tattoo area 3 times a day',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Apply cream every 8 hours',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: const <Widget>[
                Text(
                  'For the first month:',
                  textScaleFactor: 1.5,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Do not itch skin',
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Moisturise tattoo area once a day',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(
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
