import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import '../../theme.dart';

class SingleArtistScreen extends StatelessWidget {
  const SingleArtistScreen({Key key, this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final TextStyle body = Theme.of(context).textTheme.body1;
    final TextStyle subheading = Theme.of(context).textTheme.subtitle;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          artist.name.toUpperCase(),
          style: Theme.of(context).textTheme.headline.copyWith(fontSize: 22),
        ),
        backgroundColor: Colors.transparent,
        elevation: 40,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).accentColor,
        onPressed: () {
          final ScreenNavigator nav = sl.get<ScreenNavigator>();
          nav.openArtistConfirmScreen(context, artist);
        },
      ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: ListView(
          children: <Widget>[
            Card(
              child: artist.profileImage,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: largeBorderRadius,
              ),
              elevation: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20),
                  Text('Ricky Williams opened up South City Market in 2019 as...', style: body),
                  SizedBox(height: 40),
                  Text('Style', style: subheading),
                  Text('Ricky\'s main styles are...', style: body),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
