import 'package:flutter/material.dart';
import 'package:inkstep/page/onboarding.dart';

void main() => runApp(Inkstep());

var hintStyle = TextStyle(color: baseColors['gray']);

const baseColors = ColorSwatch<String>(0xFF0A0D18, {
  'dark': Color(0xFF313639),
  'gray': Color(0xFF6b7080),
  'light': Color(0xFFFFFFFF),
});

class Inkstep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final app = MaterialApp(
      title: 'inkstep',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.deepPurple,
        primaryColor: baseColors['dark'],
        backgroundColor: baseColors['dark'],
        cardColor: baseColors['light'],
        cardTheme: CardTheme(
          color: baseColors['light'],
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
          title: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w500),
          body1: TextStyle(
            fontSize: 14.0,
          ),
        ),
      ),
      home: Onboarding(),
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
