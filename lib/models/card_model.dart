import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_status.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.description,
    @required this.artistName,
    @required this.images,
    @required this.status,
    @required this.position,
    @required this.palette,
  }) : super(<dynamic>[description, artistName, images, status, position]);

  JourneyStatus status;
  String description;
  String artistName;
  List<Image> images;
  int position;
  PaletteGenerator palette;

  String get aftercareID => 'aftercare_button_$position';

  TextRange get quote => TextRange(start: 400, end: 500);
}
