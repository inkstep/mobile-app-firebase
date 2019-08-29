import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/pages/journeys_screen.dart';
import 'package:inkstep/ui/pages/loading_screen.dart';
import 'package:inkstep/ui/pages/onboarding.dart';

import 'models/user_model.dart';

void main() {
  // Set up Service Locator
  setup();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

  runApp(Inkstep());
}

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inkstep',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: FutureBuilder<bool>(
        future: UserModel.exists(),
        builder: (buildContext, user) {
          if (user.hasData) {
            if (user.data) {
              return JourneysScreen();
            }
            return Onboarding();
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
