import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';

abstract class JourneysState extends Equatable {
  JourneysState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class JourneysUninitialised extends JourneysState {
  @override
  String toString() => 'JourneyUninitialised';
}

class JourneyError extends JourneysState {
  @override
  String toString() => 'JourneyError';
}

class JourneyLoaded extends JourneysState {
  JourneyLoaded({this.journeys}) : super(<dynamic>[journeys]);

  final List<Journey> journeys;

  @override
  String toString() => 'JourneyLoaded { journeys: ${journeys.length}';
}
