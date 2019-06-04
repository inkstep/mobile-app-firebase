import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/models/user_model.dart';
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

class JourneysLoaded extends JourneysState {
  JourneysLoaded({@required this.user, @required this.journeys}) : super(<dynamic>[user, journeys]);

  final User user;
  final List<Journey> journeys;

  @override
  String toString() => 'JourneysLoaded { user: $user, journeys: ${journeys?.length} }';
}
