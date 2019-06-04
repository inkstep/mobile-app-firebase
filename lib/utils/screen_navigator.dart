import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/ui/pages/artists_screen.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/new_journey_screen.dart';
import 'package:inkstep/ui/pages/studios_screen.dart';

class ScreenNavigator {
  void openViewJourneysScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (context) => JourneysScreen(
                onInit: () {
                  final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
                  journeyBloc.dispatch(LoadJourneys());
                },
              )),
    );
  }

  void openArtistSelection(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => ArtistSelectionScreen()),
    );
  }

  void openStudioSelection(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => StudioSelectionScreen()),
    );
  }

  void openNewJourneyScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => NewJourneyScreen()),
    );
  }
}
