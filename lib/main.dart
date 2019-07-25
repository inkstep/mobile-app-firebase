import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/simple_bloc_delegate.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/resources/offline_journeys_repository.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      //journeysRepository: JourneysRepository(webClient: WebRepository(client: client)),
      journeysRepository: OfflineJourneysRepository(),
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
        theme: appTheme,
        home: SetInitialPage(updateUserId: updateUserId, localUserId: localUserId),
      ),
      bloc: _journeyBloc,
    );
  }
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
