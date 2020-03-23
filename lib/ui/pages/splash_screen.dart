import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/ui/pages/home_screen.dart';
import 'package:inkstep/ui/pages/welcome_back_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _shouldHoldSplash = true;

  // Load everything needed globally before the app starts
  @override
  void initState() {
    super.initState();
    Future<dynamic>.delayed(
      const Duration(seconds: 2),
      () => setState(() => _shouldHoldSplash = false),
    );
  }

  // TODO(mm) display splash screen and hold while loading, before displaying the home screen
  @override
  Widget build(BuildContext context) {
    if (_shouldHoldSplash) {
      return WelcomeBackScreen(name: null, loading: false);
    }
    return HomeScreen(journeys: []);
  }
}
