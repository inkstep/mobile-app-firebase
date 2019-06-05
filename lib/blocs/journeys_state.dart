import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysState extends Equatable {
  JourneysState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class JourneysNoUser extends JourneysState {
  @override
  String toString() => 'JourneysNoUser';
}

class JourneyError extends JourneysState {
  JourneyError({@required this.prev}) : super(<dynamic>[prev]);

  final JourneysState prev;

  @override
  String toString() => 'JourneysError { prev : $prev } ';
}

class JourneysWithUser extends JourneysState {
  JourneysWithUser({@required this.userId, @required this.journeys})
      : super(<dynamic>[userId, journeys]);

  final int userId;
  final List<Journey> journeys;

  @override
  String toString() => 'JourneysWithUser { userId: $userId, journeys: ${journeys?.length} }';
}
