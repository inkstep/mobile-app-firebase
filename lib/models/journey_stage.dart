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
        return AppointmentOfferReceived(DateTime.parse(json['bookingDate']));
      case 4:
        return BookedIn(DateTime.parse(json['bookingDate']));
      case 5:
        return Aftercare(DateTime.parse(json['bookingDate']));
      case 6:
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

  // TODO(DJRHails): They => ArtistName
  @override
  String toString() => "They'll do it!";

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
  String toString() => 'Appointment offered!';

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 3;
}

class BookedIn extends JourneyStage {
  BookedIn(this.bookedDate);
  final DateTime bookedDate;

  @override
  int get progress => 60;

  @override
  String toString() => 'Booked In';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 4;
}

class Aftercare extends JourneyStage {
  Aftercare(this.appointmentDate);
  final DateTime appointmentDate;

  @override
  int get progress => 60 + (DateTime.now().difference(appointmentDate).inDays * 30 ~/ 93);

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
