import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';

abstract class JourneyState extends Equatable {
  JourneyState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class JourneyUninitialised extends JourneyState {
  @override
  String toString() => 'JourneyUninitialised';
}

class JourneyError extends JourneyState {
  @override
  String toString() => 'JourneyError';
}

class JourneyLoaded extends JourneyState {
  JourneyLoaded({this.journeys}) : super(<dynamic>[journeys]);

  final List<Journey> journeys;

  @override
  String toString() => 'JourneyLoaded { journeys: ${journeys.length}';
}
