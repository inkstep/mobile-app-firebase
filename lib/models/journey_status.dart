import 'package:equatable/equatable.dart';

abstract class JourneyStatus extends Equatable {
  JourneyStatus([List<dynamic> props = const <dynamic>[]]) : super(props);
  int get progress;
}

class WaitingForResponse extends JourneyStatus {
  @override
  String toString() => 'Waiting For Response';

  @override
  int get progress => 20;
}
