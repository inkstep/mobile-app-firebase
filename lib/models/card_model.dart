import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_status.dart';
import 'package:meta/meta.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.description,
    @required this.artistName,
    @required this.images,
    @required this.status,
    @required this.position,
  }) : super(<dynamic>[description, artistName, images, status, position]);

  JourneyStatus status;
  String description;
  String artistName;
  List<Image> images;
  int position;

  String get aftercareID => 'aftercare_button_$position';
}
