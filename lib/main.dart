import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/theme.dart';
import 'package:inkstep/ui/pages/splash_screen.dart';

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
      title: 'SOUTHCITYMARKET',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: SplashScreen(),
    );
  }
}
