import 'package:flutter/cupertino.dart';
import 'package:inkstep/resources/events.dart';

final List<Guest> offlineGuests = [
  Guest(name: 'James Smith', date: DateTime(2020, 4, 12, 10, 00)),
];

class Guest extends Event {
  Guest({@required String name, @required DateTime date}) : super(name: name, date: date);
}
