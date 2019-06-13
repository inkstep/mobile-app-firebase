import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.description,
    @required this.size,
    @required this.artistName,
    @required this.bodyLocation,
    @required this.images,
    @required this.quote,
    @required this.stage,
    @required this.index,
    @required this.palette,
    @required this.journeyId,
    @required this.bookedDate,
  }) : super(<dynamic>[
          description,
          artistName,
          bodyLocation,
          size,
          quote,
          images,
          stage,
          index,
          bookedDate
        ]);

  JourneyStage stage;
  String description;
  String artistName;
  String bodyLocation;
  String size;
  List<Image> images;
  TextRange quote;
  int index;
  int journeyId;
  PaletteGenerator palette;
  DateTime bookedDate;

  String get aftercareID => 'aftercare_button_$index';
}
