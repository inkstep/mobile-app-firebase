import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/new_screen.dart';

class ScreenNavigator {
  void openJourneyScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (context) => JourneysScreen(
                onInit: () {
                  final JourneysBloc journeyBloc =
                      BlocProvider.of<JourneysBloc>(context);
                  journeyBloc.dispatch(LoadJourneys());
                },
              )),
    );
  }

  void openNewScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(builder: (context) => NewScreen()),
    );
  }
}
