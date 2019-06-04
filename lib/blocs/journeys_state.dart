import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysState extends Equatable {
  JourneysState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class JourneysUninitialised extends JourneysState {
  @override
  String toString() => 'JourneysUninitialised';
}

class JourneyError extends JourneysState {
  @override
  String toString() => 'JourneysError';
}

class JourneyLoaded extends JourneysState {
  JourneyLoaded({@required this.journeys}) : super(<dynamic>[journeys]);

  final List<Journey> journeys;

  @override
  String toString() => 'JourneysLoaded { journeys: ${journeys?.length}';
}
