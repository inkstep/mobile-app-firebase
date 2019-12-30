import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/user.dart';
import 'package:inkstep/ui/pages/home_screen.dart';
import 'package:inkstep/ui/pages/landing_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  AuthResult _auth;
  String _name;

  bool _shouldHoldSplash = true;
  bool _shouldHoldLoading = false;

  // Load everything needed globally before the app starts
  @override
  void initState() {
    super.initState();

    Future<dynamic>.delayed(
      const Duration(seconds: 2),
      () => setState(() => _shouldHoldSplash = false),
    );

    // Load other async data here
    User.getName().then((name) => setState(() => _name = name));
    FirebaseAuth.instance.signInAnonymously().then((user) => setState(() => _auth = user));
  }

  // Display splash screen while loading, before displaying the home screen
  @override
  Widget build(BuildContext context) {
    // TODO(mm): proper security rules for firebase
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('journeys')
          .where('auth_uid', isEqualTo: _auth == null ? '-1' : _auth.user.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // Display splash screen for a minimum of k seconds
        if (_shouldHoldSplash) {
          return LandingScreen(name: _name, loading: false);
        }

        // Check if we are done loading by the time splash screen has been displayed
        if (_auth == null || !snapshot.hasData) {
          _shouldHoldLoading = true;
          Future<dynamic>.delayed(
            const Duration(seconds: 2),
            () => setState(() => _shouldHoldLoading = false),
          );
          return LandingScreen(name: _name, loading: true);
        }

        // If we had to display loading, display it for minimum of k seconds
        if (_shouldHoldLoading) {
          return LandingScreen(name: _name, loading: true);
        }

        return HomeScreen(journeys: snapshot.data.documents);
      },
    );
  }
}
