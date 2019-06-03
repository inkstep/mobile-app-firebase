import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneysEvent {
  AddJourney(this.journey) : super(<dynamic>[journey]);

  final Journey journey;

  @override
  String toString() => 'AddJourney { journey: $journey }';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}
