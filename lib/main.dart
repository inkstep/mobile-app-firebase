import 'package:flutter/material.dart';
import 'package:inkstep/page/journey.dart';
import 'package:inkstep/page/onboarding.dart';
import 'package:inkstep/page/studios.dart';
import 'package:inkstep/theming.dart';

void main() => runApp(Inkstep());

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'inkstep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: baseColors['light'],
        primaryColor: baseColors['dark'],
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
          body1: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: Onboarding(), //TopTabs(),
    );

    return app;
  }
}

class TopTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text('inkstep.'),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Journeys'),
                Tab(text: 'Studios'),
                Tab(text: 'Artists'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              JourneyPage(),
              StudiosPage(),
              Icon(Icons.brush),
            ],
          ),
        ));
  }
}
