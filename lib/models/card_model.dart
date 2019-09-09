import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:palette_generator/palette_generator.dart';

import 'artists_model.dart';
import 'firestore.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.journey,
    @required this.artist,
    this.palette,
  }) : super(<dynamic>[journey.id,]);

  final Journey journey;
  final ArtistModel artist;

  PaletteGenerator palette;

  String get aftercareID => 'care_button_${journey.id}';
  String get messagesID => 'messages_button_${journey.id}';
}
