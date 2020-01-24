import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const baseColors = ColorSwatch<String>(0xFF0A0D18, {
  'dark': Colors.black,
  'gray': Color(0xFF424b54),
  'light': Color(0xFFFFFFFF),
  'error': Color(0xFFFF0000),
  'accent1': Color(0xFFF54B64),
  'accent2': Color(0xFFF78361),
});

final hintStyle = TextStyle(color: baseColors['gray']);

final appTheme = ThemeData(
  brightness: Brightness.dark,
  accentColor: baseColors['accent1'],
  primaryColor: baseColors['dark'],
  backgroundColor: baseColors['dark'],
  dialogBackgroundColor: baseColors['dark'],
  disabledColor: baseColors['grey'],
  cardColor: baseColors['light'],
  canvasColor: baseColors['dark'],
  textTheme: _getTextWithColor(baseColors['light']),
  primaryTextTheme: _getTextWithColor(baseColors['light']),
  accentTextTheme: _getTextWithColor(baseColors['dark']),
  iconTheme: IconThemeData(color: baseColors['light']),
  accentIconTheme: IconThemeData(color: baseColors['dark']),
  buttonTheme: ButtonThemeData(buttonColor: baseColors['dark']),
  cursorColor: baseColors['dark'],
  toggleableActiveColor: baseColors['dark'],
  cardTheme: CardTheme(
    color: baseColors['light'],
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: smallBorderRadius),
  ),
);

final smallBorderRadius = BorderRadius.circular(16.0);
final mediumBorderRadius = BorderRadius.circular(24.0);
final largeBorderRadius = BorderRadius.circular(32.0);

TextTheme _getTextWithColor(Color color) => TextTheme(
  headline: TextStyle(
    color: color,
    fontFamily: 'Velocista',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 40,
    fontWeight: FontWeight.w600,
  ),
  subhead: TextStyle(
    color: color,
    fontFamily: 'Velocista',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 28,
    fontWeight: FontWeight.w300,
  ),
  title: TextStyle(
    color: color,
    fontFamily: 'Heebo',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 28,
    fontWeight: FontWeight.w300,
  ),
  subtitle: TextStyle(
    color: color,
    fontFamily: 'Heebo',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
  body1: TextStyle(
    color: color,
    fontFamily: 'Velocista',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  body2: TextStyle(
    color: color,
    fontFamily: 'Heebo',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 18,
    fontWeight: FontWeight.w400,
  ),
  caption: TextStyle(
    color: color,
    fontFamily: 'Heebo',
    fontFamilyFallback: const ['Roboto'],
    fontSize: 12,
    fontWeight: FontWeight.w400,
  )
);
