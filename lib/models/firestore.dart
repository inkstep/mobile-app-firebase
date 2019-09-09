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
    @required this.artistId,
    @required this.description,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.stage,
  });

  factory Journey.fromMap(Map<String, dynamic> map) {
    return Journey(
      id: map['id'],
      artistId: map['artistId'],
      description: map['description'],
      size: map['size'],
      position: map['position'],
      availability: map['availability'],
      stage: JourneyStage.fromMap(map),
    );
  }

  final String id;
  final int artistId;
  final String description;
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
