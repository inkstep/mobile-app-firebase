import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class JourneyStage extends Equatable {
  JourneyStage([List<dynamic> props = const <dynamic>[]]) : super(props);

  factory JourneyStage.fromJson(Map<String, dynamic> json) {
    switch (json['stage']) {
      case 0:
        return WaitingForQuote();
      case 1:
        return QuoteReceived(TextRange(start: json['quoteLower'], end: json['quoteUpper']));
      case 2:
        return WaitingForAppointmentOffer();
      case 3:
        return AppointmentOfferReceived(json['offeredAppointment']);
      case 4:
        return BookedIn();
      case 5:
        return ImmediateAftercare();
      case 6:
        return WeekOfAftercare();
      case 7:
        return MonthOfAftercare();
      case 8:
        return Healed();
      default:
        return InvalidStage();
    }
  }

  int get progress;
  bool get userActionRequired;
  int get numberRepresentation;
}

class WaitingForQuote extends JourneyStage {
  @override
  int get progress => 20;

  @override
  String toString() => 'Awaiting artist\'s response';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 0;
}

class QuoteReceived extends JourneyStage {
  QuoteReceived(this.quote);

  final TextRange quote;

  @override
  int get progress => 30;

  @override
  String toString() => "You've been sent a price!";

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 1;
}

class WaitingForAppointmentOffer extends JourneyStage {
  @override
  int get progress => 35;

  @override
  String toString() => 'Awaiting Appointment Slot';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 2;
}

class AppointmentOfferReceived extends JourneyStage {
  AppointmentOfferReceived(this.appointmentDate);
  final DateTime appointmentDate;

  @override
  int get progress => 40;

  @override
  String toString() => "You've been offered an appointment!";

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 3;
}

class BookedIn extends JourneyStage {
  @override
  int get progress => 60;

  @override
  String toString() => 'Booked In';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 4;
}

class ImmediateAftercare extends JourneyStage {
  @override
  int get progress => 65;

  @override
  String toString() => 'Tattoo Healing';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 5;
}

class WeekOfAftercare extends JourneyStage {
  @override
  int get progress => 70;

  @override
  String toString() => 'Tattoo Healing';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 6;
}

class MonthOfAftercare extends JourneyStage {
  @override
  int get progress => 80;

  @override
  String toString() => 'Tattoo Healing';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 7;
}

class Healed extends JourneyStage {
  @override
  int get progress => 95;

  @override
  String toString() => 'Send {ARTISTNAME} a picture?';

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 8;
}

class InvalidStage extends JourneyStage {
  @override
  int get progress => 0;

  @override
  String toString() => 'Invalid';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => -1;
}
