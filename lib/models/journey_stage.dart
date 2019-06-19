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
        return WaitingForAppointmentOffer(
            TextRange(start: json['quoteLower'], end: json['quoteUpper']));
      case 3:
        return AppointmentOfferReceived(DateTime.parse(json['bookingDate']),
            TextRange(start: json['quoteLower'], end: json['quoteUpper']));
      case 4:
        return BookedIn(DateTime.parse(json['bookingDate']),
            TextRange(start: json['quoteLower'], end: json['quoteUpper']));
      case 5:
        return Aftercare(DateTime.parse(json['bookingDate']));
      case 6:
        return Healed();
      case 7:
        return Finished();
      case 8:
        return WaitingList(TextRange(start: json['quoteLower'], end: json['quoteUpper']));
      default:
        return InvalidStage();
    }
  }

  int get progress;
  bool get userActionRequired;
  int get numberRepresentation;
  IconData get icon;
}

abstract class JourneyStageWithQuote extends JourneyStage {
  JourneyStageWithQuote(this.quote);

  final TextRange quote;
}

class WaitingForQuote extends JourneyStage {
  @override
  int get progress => 20;

  @override
  String toString() => 'Awaiting response';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 0;

  @override
  IconData get icon => Icons.swap_horiz;
}

class QuoteReceived extends JourneyStageWithQuote {
  QuoteReceived(TextRange quote) : super(quote);

  @override
  int get progress => 30;

  // TODO(DJRHails): They => ArtistName
  @override
  String toString() => "They'll do it!";

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 1;

  @override
  IconData get icon => Icons.priority_high;
}

class WaitingForAppointmentOffer extends JourneyStageWithQuote {
  WaitingForAppointmentOffer(TextRange quote) : super(quote);

  @override
  int get progress => 35;

  @override
  String toString() => 'Awaiting appointment slot';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 2;

  @override
  IconData get icon => Icons.compare_arrows;
}

class AppointmentOfferReceived extends JourneyStageWithQuote {
  AppointmentOfferReceived(this.appointmentDate, TextRange quote) : super(quote);
  final DateTime appointmentDate;

  @override
  int get progress => 40;

  @override
  String toString() => 'Appointment offered!';

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 3;

  @override
  IconData get icon => Icons.date_range;
}

class BookedIn extends JourneyStageWithQuote {
  BookedIn(this.bookedDate, TextRange quote) : super(quote);
  final DateTime bookedDate;

  @override
  int get progress => 60;

  @override
  String toString() => 'Booked In';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 4;

  @override
  IconData get icon => Icons.event;
}

class WaitingList extends JourneyStageWithQuote {
  WaitingList(TextRange quote) : super(quote);

  @override
  IconData get icon => Icons.access_time;

  @override
  int get numberRepresentation => 8;

  @override
  int get progress => 50;

  @override
  String toString() => 'Wating List';

  @override
  bool get userActionRequired => false;
}

class Aftercare extends JourneyStage {
  Aftercare(this.appointmentDate);
  final DateTime appointmentDate;

  @override
  int get progress =>
      60 + (DateTime.now().difference(appointmentDate).inDays * 30 ~/ 93).clamp(1, 35);

  @override
  String toString() => 'Tattoo healing';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 5;

  @override
  IconData get icon => Icons.healing;
}

class Healed extends JourneyStage {
  @override
  int get progress => 95;

  @override
  String toString() => 'You\'re fully healed!';

  @override
  bool get userActionRequired => true;

  @override
  int get numberRepresentation => 6;

  @override
  IconData get icon => Icons.done_outline;
}

class Finished extends JourneyStage {
  @override
  int get progress => 100;

  @override
  String toString() => 'Journey Complete';

  @override
  bool get userActionRequired => false;

  @override
  int get numberRepresentation => 7;

  @override
  IconData get icon => Icons.done;
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

  @override
  IconData get icon => Icons.error;
}
