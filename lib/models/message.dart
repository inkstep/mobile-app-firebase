import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Message extends Equatable {
  Message({
    @required this.authUid,
    @required this.journeyId,
    @required this.timestamp,
    @required this.content,
  }) : super(<dynamic>[authUid, journeyId, timestamp]);

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      authUid: map['auth_uid'],
      journeyId: map['journeyId'],
      timestamp: DateTime.parse(map['timestamp']),
      content: <String, dynamic>{}, // TODO(mm): decode content when retrieving
    );
  }

  final String authUid;
  final String journeyId;
  final DateTime timestamp;
  final Map<String, dynamic> content;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{
      'auth_uid': authUid,
      'journeyId': journeyId,
      'timestamp': timestamp,
    };
    map.addAll(content);
    return map;
  }
}
