import 'package:flutter/cupertino.dart';

final List<Event> offlineEvents = [
  Event(name: 'Flash Day', date: DateTime(2020, 4, 15, 14, 00)),
];

class Event {
  Event({@required this.name = 'default', @required this.date});

  final String name;
  final DateTime date;
}
