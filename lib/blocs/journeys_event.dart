import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_info_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneysEvent {
  AddJourney({@required this.journeyInfo}) : super(<dynamic>[journeyInfo]);

  final JourneyInfo journeyInfo;

  @override
  String toString() => 'AddJourney { journey_info: $journeyInfo }';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}
