import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneysEvent {
  AddJourney({@required this.user, @required this.journey}) : super(<dynamic>[user, journey]);

  final Journey journey;
  final User user;

  @override
  String toString() => 'AddJourney { user: $user, journey: $journey }';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}
