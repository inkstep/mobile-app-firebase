import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inkstep/models/journey_stage.dart';

class Message extends Equatable {
  Message({
    @required this.authUid,
    @required this.journeyId,
    @required this.timestamp,
    @required this.stage,
  }) : super(<dynamic>[authUid, journeyId, timestamp]);

  factory Message.fromMap(Map<String, dynamic> map) {
    final DateTime dateTime = (map['timestamp'] is Timestamp) ? map['timestamp'].toDate() : DateTime.parse(map['timestamp']);
    return Message(
      authUid: map['auth_uid'],
      journeyId: map['journeyId'],
      timestamp: dateTime,
      stage: JourneyStage.fromMap(map),
    );
  }

  final String authUid;
  final String journeyId;
  final DateTime timestamp;
  final JourneyStage stage;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{
      'auth_uid': authUid,
      'journeyId': journeyId,
      'timestamp': timestamp,
    };
    map.addAll(stage.toMap());
    return map;
  }
}
