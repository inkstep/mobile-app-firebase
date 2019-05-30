import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_event.dart';
import 'package:inkstep/ui/pages/journey_screen.dart';
import 'package:inkstep/ui/pages/new_screen.dart';

class ScreenNavigator {
  void openJourneyScreen(BuildContext context) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
          builder: (context) => JourneyScreen(
                onInit: () {
                  final JourneyBloc journeyBloc =
                      BlocProvider.of<JourneyBloc>(context);
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
