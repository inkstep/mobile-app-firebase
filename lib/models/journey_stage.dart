import 'package:equatable/equatable.dart';
import 'package:inkstep/models/journey_entity.dart';

abstract class JourneyStage extends Equatable {
  JourneyStage([List<dynamic> props = const <dynamic>[]]) : super(props);

  factory JourneyStage.fromJson(Map<String, dynamic> json) {
    switch (json['stage']) {
      case 0:
        return WaitingForQuote();
      case 1:
        return QuoteReceived(json['quote']);
      case 2:
        return WaitingForAppointmentOffer();
      case 3:
        return AppointmentOfferReceived(json['offeredAppointment']);
      case 4:
        return BookedIn();
      default:
        return InvalidStage();
    }
  }

  int get progress;
  bool notify = false;
}

class WaitingForQuote extends JourneyStage {
  @override
  int get progress => 20;

  @override
  String toString() => 'Waiting For Response';
}

class QuoteReceived extends JourneyStage {

  QuoteReceived(this.quote);

  final int quote;

  @override
  int get progress => 30;

  @override
  String toString() => "You've been sent a quote!";
}

class WaitingForAppointmentOffer extends JourneyStage {
  @override
  int get progress => 35;

  @override
  String toString() => 'Waiting for Response';
}

class AppointmentOfferReceived extends JourneyStage {

  AppointmentOfferReceived(this.appointmentDate);
  final DateTime appointmentDate;

  @override
  int get progress => 40;

  @override
  String toString() => "You've been offered an appointment!";
}

class BookedIn extends JourneyStage {
  @override
  int get progress => 60;

  @override
  String toString() => 'Booked In';
}

class InvalidStage extends JourneyStage {
  @override
  int get progress => 0;

  @override
  String toString() => 'Invalid';
}
