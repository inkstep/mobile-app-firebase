import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';

abstract class JourneyEvent extends Equatable {
  JourneyEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneyEvent {
  AddJourney(this.journey) : super(<dynamic>[journey]);

  final Journey journey;

  @override
  String toString() => 'AddJourney { journey: $journey }';
}

class LoadJourneys extends JourneyEvent {
  @override
  String toString() => 'LoadJourneys';
}
