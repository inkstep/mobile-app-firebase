import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const baseColors = ColorSwatch<String>(0xFF0A0D18, {
  'dark': Color(0xFF202431),
  'gray': Color(0xFF4E586E),
  'light': Color(0xFFFFFFFF),
  'error': Color(0xFFFF0000),
  'accent1': Color(0xFFF54B64),
  'accent2': Color(0xFFF78361),
});

var hintStyle = TextStyle(color: baseColors['gray']);

var appTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: baseColors['accent1'],
  primaryColor: baseColors['dark'],
  backgroundColor: baseColors['dark'],
  dialogBackgroundColor: baseColors['dark'],
  disabledColor: baseColors['grey'],
  cardColor: baseColors['light'],
  cardTheme: CardTheme(
    color: baseColors['light'],
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  canvasColor: baseColors['dark'],
  textTheme: _getTextWithColor(baseColors['light']),
  accentTextTheme: _getTextWithColor(baseColors['dark']),
  iconTheme: _getIconWithColor(baseColors['light']),
  accentIconTheme: _getIconWithColor(baseColors['dark']),
  primaryTextTheme: _getTextWithColor(baseColors['light']),
  buttonTheme: ButtonThemeData(
    buttonColor: baseColors['dark'],
  ),
  cursorColor: baseColors['dark'],
  toggleableActiveColor: baseColors['dark'],
);

TextTheme _getTextWithColor(Color color) => TextTheme(
    headline: TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w600,
      color: color,
    ),
    subhead: TextStyle(
      fontSize: 28,
      color: color,
      fontWeight: FontWeight.w300,
    ),
    title: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w300,
      color: color,
    ),
    subtitle: TextStyle(
      fontSize: 20,
      color: color,
      fontWeight: FontWeight.w400,
    ),
    body1: TextStyle(
      fontSize: 18,
      color: color,
    ),
    caption: TextStyle(
      fontSize: 12,
      color: color,
      fontWeight: FontWeight.w400,
    ));

IconThemeData _getIconWithColor(Color color) => IconThemeData(color: color);
