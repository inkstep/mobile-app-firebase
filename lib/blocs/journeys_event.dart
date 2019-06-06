import 'package:equatable/equatable.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:meta/meta.dart';

abstract class JourneysEvent extends Equatable {
  JourneysEvent([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class AddJourney extends JourneysEvent {
  AddJourney({@required this.result}) : super(<dynamic>[result]);

  final FormResult result;

  @override
  String toString() => 'AddJourney { formResult: $result }';
}

class LoadJourneys extends JourneysEvent {
  @override
  String toString() => 'LoadJourneys';
}

class ShownFeatureDiscovery extends JourneysEvent {
  @override
  String toString() => 'ShownFeatureDiscovery';
}
