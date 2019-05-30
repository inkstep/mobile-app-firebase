import 'package:flutter/material.dart';
import 'package:inkstep/ui/pages/journey_screen.dart';
import 'package:inkstep/ui/pages/new_screen.dart';

class ScreenNavigator {
  void openJourneyScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => JourneyScreen()),
    );
  }

  void openNewScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => NewScreen()),
    );
  }
}
