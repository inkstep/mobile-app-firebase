import 'package:flutter/material.dart';
import 'package:inkstep/info_gathering.dart';
import 'package:inkstep/widgets.dart';

var darkColor = Color(0xFF0A0D18);
var grayColor = Color(0xFF6B7080);
var hintStyle = TextStyle(color: grayColor);

void main() => runApp(Inkstep());

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkstep',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        // Cursor colors
        primaryColor: darkColor,
      ),
      home: NewJourneyRoute(),//TopTabs(),
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
            title: Text('Inkstep.'),
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
