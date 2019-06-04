import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/models/user_model.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneysEvent {
  AddJourney(this.journey, this.user) : super(<dynamic>[journey]);

  final Journey journey;
  final User user;

  @override
  String toString() => 'AddJourney { journey: $journey, user: $user }';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}
