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
    return Message(
      authUid: map['auth_uid'],
      journeyId: map['journeyId'],
      timestamp: DateTime.parse(map['timestamp']),
      stage: _decodeMessageContent(map),
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

  // TODO(mm): data model for a message instead of using Object here
  static JourneyStage _decodeMessageContent(Map<String, dynamic> map) {
    // Message is a journey stage
    if (map['stage']) {
      return JourneyStage.fromMap(map);
    }

    // TODO(mm): text only journey stage?
    return (map['text']) ? map['text'] : InvalidStage();
  }
}
