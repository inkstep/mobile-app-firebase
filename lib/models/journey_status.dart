import 'package:equatable/equatable.dart';

abstract class JourneyStatus extends Equatable {
  JourneyStatus([List<dynamic> props = const <dynamic>[]]) : super(props);

  factory JourneyStatus.forCode(int forCode) {
    switch (forCode) {
      case 0:
        return WaitingForResponse();
      case 1:
        return BookedIn();
      default:
        return InvalidStatus();
    }
  }

  int get progress;
  bool notify = false;
}

class WaitingForResponse extends JourneyStatus {
  @override
  int get progress => 20;

  @override
  String toString() => 'Waiting For Response';
}

class BookedIn extends JourneyStatus {
  @override
  int get progress => 60;

  @override
  String toString() => 'Booked In';
}

class InvalidStatus extends JourneyStatus {
  @override
  int get progress => 0;

  @override
  String toString() => 'Invalid';
}
