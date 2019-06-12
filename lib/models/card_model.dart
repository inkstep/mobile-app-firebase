import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';

class CardModel extends Equatable {


  CardModel({
    @required this.description,
    @required this.artistName,
    @required this.images,
    @required this.stage,
    @required this.position,
    @required this.palette,
    @required this.journeyId,
    @required this.bookedDate,
  }) : super(<dynamic>[description, artistName, images, stage, position, bookedDate]);

  JourneyStage stage;
  String description;
  String artistName;
  List<Image> images;
  int position;
  int journeyId;
  PaletteGenerator palette;
  DateTime bookedDate;

  String get aftercareID => 'aftercare_button_$position';
}
