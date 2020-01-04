import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/ui/components/artist_card.dart';
import 'package:inkstep/ui/components/bold_call_to_action.dart';
import 'package:inkstep/utils/screen_navigator.dart';

class ConfirmArtistScreen extends StatelessWidget {

  const ConfirmArtistScreen({Key key, this.artist}) : super(key: key);

  final Artist artist;

  @override
  Widget build(BuildContext context) {
    final TextStyle body = Theme.of(context).textTheme.body1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: ArtistCard(
                artist: artist,
              ).buildItems(context) +
              [
                Spacer(flex: 2),
                BoldCallToAction(
                  onTap: () {
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openNewJourneyScreen(context, artist.artistId);
                  },
                  textColor: Colors.black,
                  color: Colors.white,
                  label: 'Get a Quote',
                ),
                Spacer(flex: 1),
                Text('Explain what a quote is here...', style: body),
                Spacer(flex: 4),
                BoldCallToAction(
                  onTap: () {
                    final ScreenNavigator nav = sl.get<ScreenNavigator>();
                    nav.openNewJourneyScreen(context, artist.artistId);
                  },
                  textColor: Colors.black,
                  color: Colors.white,
                  label: 'Book a Free Consultation',
                ),
                Spacer(flex: 1),
                Text('Explain what a free consultation is here...', style: body),
                Spacer(flex: 4),
              ],
        ),
      ),
    );
  }
}
