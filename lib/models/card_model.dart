import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';

import 'artists_model.dart';
import 'firestore.dart';
import 'journey_stage.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.journey,
    @required this.artist,
    @required this.stage,
    this.images,
    this.palette,
  }) : super(<dynamic>[journey.id,]);

  final Journey journey;
  final ArtistModel artist;
  final JourneyStage stage;

  List<Image> images;

  PaletteGenerator palette;

  String get aftercareID => 'care_button_${journey.id}';
  String get messagesID => 'messages_button_${journey.id}';
}
