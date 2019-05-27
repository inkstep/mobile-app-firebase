import 'package:flutter/material.dart';
import 'package:my_app/info_gathering.dart';
import 'package:my_app/widgets.dart';
import 'info_gathering/concept_question.dart';

void main() => runApp(Inkstep());

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inkstep',
      theme: ThemeData(brightness: Brightness.dark, accentColor: Colors.white),
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
              tabs: [
                Tab(text: "Journeys"),
                Tab(text: "Studios"),
                Tab(text: "Artists"),
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
