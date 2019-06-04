import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/components/profile_row.dart';

class ArtistSelectionScreen extends StatelessWidget {
  ArtistSelectionScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Select an Artist'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
        child: ListView(
          children: <Widget>[
            ProfileRow(
              name: 'ricky',
              studioName: 'scm',
              imagePath: 'assets/ricky.png',
            ),
            ProfileRow(
              name: 'ricky',
              studioName: 'scm',
              imagePath: 'assets/ricky.png',
            ),
            ProfileRow(
              name: 'ricky',
              studioName: 'scm',
              imagePath: 'assets/ricky.png',
            ),
            ProfileRow(
              name: 'ricky',
              studioName: 'scm',
              imagePath: 'assets/ricky.png',
            ),
          ],
        ),
      ),
    );
  }
}
