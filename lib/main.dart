import 'package:flutter/material.dart';
import 'package:inkstep/journeys/journeys.dart';
import 'package:inkstep/onboarding.dart';
import 'package:inkstep/studios_page.dart';
import 'package:inkstep/theming.dart';

void main() => runApp(Inkstep());

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'inkstep',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        primaryColor: darkColor,
      ),
      debugShowCheckedModeBanner: false,
      home: Onboarding(), //TopTabs(),
    );
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
