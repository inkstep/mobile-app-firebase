import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class EmptyJourneyEntity extends Equatable {
  EmptyJourneyEntity({
    @required this.userId,
    @required this.artistId,
    @required this.description,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.noImages,
    @required this.style,
  }) : super(<dynamic>[
          userId,
          artistId,
          description,
          size,
          position,
          availability,
          noImages,
          style
        ]);

  factory EmptyJourneyEntity.fromJson(Map<String, dynamic> json) {
    return EmptyJourneyEntity(
        userId: json['userID'],
        artistId: json['artistID'],
        description: json['tattooDesc'],
        size: json['size'],
        position: json['position'],
        availability: json['availability'],
        noImages: int.parse(json['noRefImages']),
        style: json['style']);
  }

  final int userId;
  final int artistId;
  final String description;
  final String size;
  final String position;
  final String availability;
  final int noImages;
  final String style;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userID': userId,
      'artistID': artistId,
      'tattooDesc': description,
      'size': size,
      'position': position,
      'availability': availability,
      'noRefImages': noImages,
      'style': style,
    };
  }
}
