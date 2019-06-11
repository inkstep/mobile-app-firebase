import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class JourneyStatus extends Equatable {
  JourneyStatus([List<dynamic> props = const <dynamic>[]]) : super(props);
  int get progress;
  bool notify = false;
}

class WaitingForResponse extends JourneyStatus {
  @override
  int get progress => 20;
}

class BookedIn extends JourneyStatus {
  @override
  int get progress => 60;
}

class InvalidStatus extends JourneyStatus {
  @override
  int get progress => 0;
}

class JourneyStatusFactory {
  static JourneyStatus journeyStatus({@required int forCode}) {
    switch (forCode) {
      case 0:
        return WaitingForResponse();
      default:
        return InvalidStatus();
    }
  }
}
