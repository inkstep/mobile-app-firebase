import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/logo.dart';

class AfterCareScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Aftercare: ',
              textScaleFactor: 1.5,
            ),
            Hero(
              tag: 'logo',
              child: LogoWidget(),
            ),
          ],
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'For first 2 hours:',
                  textScaleFactor: 1.5,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Leave in plastic wrap',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Only remove after 2 hours',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'For first week:',
                  textScaleFactor: 1.5,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Do not itch skin',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Moisturise tattoo area 3 times a day',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'NEVER EXFOLIATE',
                  textScaleFactor: 1.25,
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Apply cream every 8 hours',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'For first month:',
                  textScaleFactor: 1.5,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Do not itch skin',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'DO NOT EXFOLIATE',
                  textScaleFactor: 1.25,
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Text(
                  'Moisturise tattoo area once a day',
                  textAlign: TextAlign.start,
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            RaisedButton(
                onPressed: () {
                  print('notifications unimplemented');
                },
                elevation: 15.0,
                color: Theme.of(context).cardColor,
                padding: EdgeInsets.fromLTRB(32.0, 16.0, 32.0, 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                child: Text('Enable Aftercare Notifications!',
                    style: TextStyle(color: Theme.of(context).primaryColorDark))),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
