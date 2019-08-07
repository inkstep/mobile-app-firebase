import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
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
  int localUserId = -1;
  void Function(int) updateUserId;

  @override
  void initState() {
    super.initState();
    client = http.Client();

    updateUserId = (userId) {
      setState(() {
        localUserId = userId;
      });
    };
  }

  @override
  void dispose() {
    client.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'inkstep',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SetInitialPage(updateUserId: updateUserId, localUserId: localUserId),
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
              // TODO: load user
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
