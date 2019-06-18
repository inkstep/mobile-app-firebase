import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/simple_bloc_delegate.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'blocs/journeys_event.dart';

void main() {
  // Set up error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.context.contains('layout')) {
      print('RENDERING ERROR:');
    }
    print(details.exception);
  };

  // Set up BlocSupervisor
  BlocSupervisor.delegate = SimpleBlocDelegate();

  // Set up Service Locator
  setup();

  runApp(Inkstep());
}

var hintStyle = TextStyle(color: baseColors['gray']);

const baseColors = ColorSwatch<String>(0xFF0A0D18, {
  'dark': Color(0xFF202431),
  'gray': Color(0xFF4E586E),
  'light': Color(0xFFFFFFFF),
  'error': Color(0xFFFF0000),
  'accent1': Color(0xFFF54B64),
  'accent2': Color(0xFFF78361),
});

class Inkstep extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InkstepState();
}

class InkstepState extends State<Inkstep> {
  http.Client client;
  JourneysBloc _journeyBloc;
  int localUserId = -1;
  void Function(int) updateUserId;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    _journeyBloc = JourneysBloc(
      journeysRepository: JourneysRepository(webClient: WebRepository(client: client)),
    );

    updateUserId = (userId) {
      setState(() {
        localUserId = userId;
      });
    };
  }

  @override
  void dispose() {
    client.close();
    _journeyBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return BlocProvider<JourneysBloc>(
      child: MaterialApp(
        title: 'inkstep',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: baseColors['accent1'],
          primaryColor: baseColors['dark'],
          backgroundColor: baseColors['dark'],
          dialogBackgroundColor: baseColors['dark'],
          disabledColor: baseColors['grey'],
          cardColor: baseColors['light'],
          cardTheme: CardTheme(
            color: baseColors['light'],
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          canvasColor: baseColors['dark'],
          textTheme: _getTextWithColor(baseColors['light']),
          accentTextTheme: _getTextWithColor(baseColors['dark']),
          iconTheme: _getIconWithColor(baseColors['light']),
          accentIconTheme: _getIconWithColor(baseColors['dark']),
          primaryTextTheme: _getTextWithColor(baseColors['light']),
          buttonTheme: ButtonThemeData(
            buttonColor: baseColors['dark'],
          ),
          cursorColor: baseColors['dark'],
          toggleableActiveColor: baseColors['dark'],
        ),
        home: SetInitialPage(updateUserId: updateUserId, localUserId: localUserId),
      ),
      bloc: _journeyBloc,
    );
  }

  TextTheme _getTextWithColor(Color color) => TextTheme(
      headline: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w600,
        color: color,
      ),
      subhead: TextStyle(
        fontSize: 28.0,
        color: color,
        fontWeight: FontWeight.w300,
      ),
      title: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w300,
        color: color,
      ),
      subtitle: TextStyle(
        fontSize: 20.0,
        color: color,
        fontWeight: FontWeight.w400,
      ),
      body1: TextStyle(
        fontSize: 18.0,
        color: color,
      ),
      caption: TextStyle(
        fontSize: 12.0,
        color: color,
        fontWeight: FontWeight.w400,
      ));

  IconThemeData _getIconWithColor(Color color) => IconThemeData(
        color: color,
      );
}

class SetInitialPage extends StatelessWidget {
  const SetInitialPage({
    Key key,
    @required this.updateUserId,
    @required this.localUserId,
  }) : super(key: key);

  final void Function(int) updateUserId;
  final int localUserId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: localUserExists(updateUserId),
      builder: (buildContext, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            // Return your login here
            return Onboarding();
          }
          // Return your home here
          return JourneysScreen(onInit: () {
            if (localUserId != -1) {
              final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
              journeyBloc.dispatch(LoadUser(localUserId));
            }
          });
        } else {
          // Return loading screen while reading preferences
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

Future<bool> localUserExists(void Function(int) updateUserId) async {
  final prefs = await SharedPreferences.getInstance();
  final int userId = prefs.getInt('userId');
  final bool toReturn = userId == null;
  if (!toReturn) {
    updateUserId(userId);
  }
  return toReturn;
}
