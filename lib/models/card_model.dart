import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_status.dart';
import 'package:meta/meta.dart';

class CardModel extends Equatable {
  CardModel({
    @required this.description,
    @required this.artistName,
    @required this.status,
    @required this.position,
  }) : super(<dynamic>[description, artistName, status, position]);

  JourneyStatus status;
  String description;
  String artistName;
  int position;

  String get aftercareID => 'aftercare_button_$position';
}
