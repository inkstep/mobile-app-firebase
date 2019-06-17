import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

// TODO(mm5917): Users should have their own bloc
class AddUser extends JourneysEvent {
  AddUser({@required this.name}) : super(<dynamic>[name]);

  final String name;

  @override
  String toString() => 'AddUser { name: $name }';
}

class UpdateUser extends JourneysEvent {
  UpdateUser({@required this.user}) : super(<dynamic>[user]);

  final User user;

  @override
  String toString() => 'UpdateUser { user: ${user.toString()} }';
}

class AddJourney extends JourneysEvent {
  AddJourney({@required this.result}) : super(<dynamic>[result]);

  final FormResult result;

  @override
  String toString() => 'AddJourney { formResult: $result }';
}

class LoadUser extends JourneysEvent {
  LoadUser(this.userId);

  final int userId;

  @override
  String toString() => 'LoadUser';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}

class LoadJourney extends JourneysEvent {
  LoadJourney(this.journeyId);

  final int journeyId;
}

class ShownFeatureDiscovery extends JourneysEvent {
  @override
  String toString() => 'ShownFeatureDiscovery';
}

class DialogJourneyEvent extends JourneysEvent {
  DialogJourneyEvent(this.journeyId);

  final int journeyId;
}

class QuoteAccepted extends DialogJourneyEvent {
  QuoteAccepted(int journeyId) : super(journeyId);

  @override
  String toString() => 'QuoteAccepted';
}

class QuoteDenied extends DialogJourneyEvent {
  QuoteDenied(int journeyId) : super(journeyId);

  @override
  String toString() => 'QuoteDenied';
}

class DateAccepted extends DialogJourneyEvent {
  DateAccepted(int journeyId) : super(journeyId);

  @override
  String toString() => 'DateAccepted';
}

class DateDenied extends DialogJourneyEvent {
  DateDenied(int journeyId) : super(journeyId);

  @override
  String toString() => 'DateDenied';
}

class LogOut extends JourneysEvent {
  LogOut(this.context);
  final BuildContext context;
}

class SendPhoto extends JourneysEvent {
  SendPhoto(this.imageData, this.userId, this.artistId, this.journeyId);

  final File imageData;
  final int userId;
  final int artistId;
  final int journeyId;

  @override
  String toString() => 'SendPhoto';
}

class RemoveJourney extends JourneysEvent {
  RemoveJourney(this.journeyId);

  final int journeyId;

  @override
  String toString() => 'RemoveJourney';
}
