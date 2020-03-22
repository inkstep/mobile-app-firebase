import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/ui/pages/artists_screen.dart';
import 'package:inkstep/ui/pages/single_artist_screen.dart';
import 'package:inkstep/ui/pages/splash_screen.dart';
import 'package:inkstep/ui/routes/fade_page_route.dart';
import 'package:inkstep/ui/routes/scale_page_route.dart';

import '../main.dart';

class ScreenNavigator {
  void pop(BuildContext context) {
    Navigator.pop(context);
  }

  void restartApp(BuildContext context) {
    Navigator.pushAndRemoveUntil<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => Inkstep()),
      (Route<dynamic> route) => false,
    );
  }


  void openHomeScreen(BuildContext context) {
    Navigator.pushReplacement<dynamic, dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => SplashScreen()),
    );
  }


  void expandArtistSelection(BuildContext context, RelativeRect rect) {
    Navigator.push<dynamic>(
      context,
      ScaleRoute(
        rect: rect,
        child: ArtistSelectionScreen(),
      ),
    );
  }

  void openSingleArtistScreen(BuildContext context, Artist artist) {
    Navigator.push<dynamic>(
      context,
      FadeRoute(
        page: SingleArtistScreen(artist: artist),
        fullscreen: true,
      ),
    );
  }
}
