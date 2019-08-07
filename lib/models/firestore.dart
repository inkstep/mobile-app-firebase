import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'journey_stage.dart';

class User {
  User({
    @required this.id,
    @required this.name,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
    );
  }

  final int id;
  final String name;
}

class Journey {
  Journey({
    @required this.id,
    @required this.userId,
    @required this.artistId,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.stage,
  });

  factory Journey.fromMap(Map<String, dynamic> map) {

    int id;
    if (map['id'] is String) {
      print('id for journey was string |:-O');
      id = int.parse(map['id']);
    } else {
      id = map['id'];
    }

    return Journey(
      id: id,
      userId: map['userID'],
      artistId: map['artistID'],
      mentalImage: map['description'],
      size: map['size'],
      position: map['position'],
      availability: map['availability'],
      stage: JourneyStage.fromInt(map['stage']),
    );
  }

  final int id;
  final int userId;
  final int artistId;
  final String mentalImage;
  final String size;
  final String position;
  final String availability;
  final JourneyStage stage;
}

class Artist extends Equatable {
  Artist({
    @required this.id,
    @required this.name
  });

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'],
      name: map['name'],
    );
  }

  final int id;
  final String name;
}
