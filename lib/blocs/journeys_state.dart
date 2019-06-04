import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:meta/meta.dart';

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

class JourneysLoaded extends JourneysState {
  JourneysLoaded({@required this.journeys}) : super(<dynamic>[journeys]);

  final List<Journey> journeys;

  @override
  String toString() => 'JourneyLoaded { journeys: ${journeys?.length}';
}
