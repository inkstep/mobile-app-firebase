import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/ui/journey_page.dart';

void main() => runApp(Inkstep());

var hintStyle = TextStyle(color: baseColors['gray']);

const baseColors = ColorSwatch<String>(0xFF0A0D18, {
  'dark': Color(0xFF313639),
  'gray': Color(0xFF6b7080),
  'light': Color(0xFFFFFFFF),
});

class Inkstep extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => InkstepState();
}

class InkstepState extends State<Inkstep> {
  final JourneyBloc _journeyBloc = JourneyBloc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BlocProvider<JourneyBloc>(
        child: JourneyPage(), //Onboarding(),
        bloc: _journeyBloc,
      ),
    );
  }

  @override
  void dispose() {
    _journeyBloc.dispose();
    super.dispose();
  }
}
