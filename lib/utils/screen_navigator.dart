import 'package:flutter/material.dart';
import 'package:inkstep/ui/pages/info_gathering.dart';
import 'package:inkstep/ui/pages/journey_page.dart';

class ScreenNavigator {
  void openJourneyScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => JourneyPage()),
    );
  }

  void openNewScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => InfoScreen()),
    );
  }
}
