import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inkstep/models/user.dart';

import 'journey_stage.dart';

class Journey {
  Journey({
    @required this.id,
    @required this.artistId,
    @required this.description,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.style,
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
      style: map['style'],
      stage: JourneyStage.fromMap(map),
    );
  }

  final String id;
  final int artistId;
  final String description;
  final String size;
  final String position;
  final String availability;
  final String style;
  final JourneyStage stage;

  // Upload this journey to firebase for the user given
  Future<String> upload(String authUid) async {
    final String name = await User.getName();
    final String email = await User.getEmail();
    final Future<DocumentReference> doc = Firestore.instance.collection('journeys').add(
      <String, dynamic>{
        'artistId': artistId,
        'auth_uid': authUid,
        'availability': availability,
        'clientEmail': email,
        'clientName': name,
        'clientPhone': '',
        'description': description,
        'position': position,
        'size': size,
        'style': style,
        'stage': 0,
        // 'quoteLower': 100,
        // 'quoteUpper': 120,
        // 'date': '2019-11-22 13:00:00',
      },
    );

    return (await doc).documentID;
  }
}
