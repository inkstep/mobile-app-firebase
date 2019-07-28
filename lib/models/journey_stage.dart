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

  String get deleteDialogHeader;

  String get deleteDialogConfirmText;

  String deleteDialogBody(String artistName);

  Widget asMessage() {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Material(
          borderRadius: BorderRadius.circular(16.0),
          color: Colors.black,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Center(child: Text('${this.toString()}'))),
        )
    );
  }
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to end your journey?';

  @override
  String get deleteDialogConfirmText => 'End Journey';

  @override
  String deleteDialogBody(String artistName) =>
      '${artistName.split(' ').first} will be notified that you do not want to proceed.';
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

  @override
  String get deleteDialogHeader =>
      'If you don\'t accept this quote, it will end your journey with this artist.';

  @override
  String get deleteDialogConfirmText => 'End Journey';

  @override
  String deleteDialogBody(String artistName) =>
      'Think about a tattoo like a dentist\'s appointment, you don\'t haggle with your dentist. '
      'Even more importantly a tattoo is not something to cheap out on.';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to end your journey?';

  @override
  String get deleteDialogConfirmText => 'End Journey';

  @override
  String deleteDialogBody(String artistName) =>
      '${artistName.split(' ').first} will be notified that you do not want to proceed.';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to end your journey?';

  @override
  String get deleteDialogConfirmText => 'End Journey';

  @override
  String deleteDialogBody(String artistName) =>
      '${artistName.split(' ').first} will be notified that you do not want to proceed.';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to cancel your booking?';

  @override
  String get deleteDialogConfirmText => 'Cancel Booking';

  @override
  String deleteDialogBody(String artistName) =>
      '${artistName.split(' ').first} will be notified and you will not get your deposit back.';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to end your journey?';

  @override
  String get deleteDialogConfirmText => 'You won\'t get notified about any cancellation slots!';

  @override
  String deleteDialogBody(String artistName) => 'End Journey';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to remove this journey?';

  @override
  String get deleteDialogConfirmText => 'Remove Journey';

  @override
  String deleteDialogBody(String artistName) =>
      'You won\'t get to see personalised aftercare advice or be able to send a photo to your '
      'artist if you proceed.';
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

  @override
  String get deleteDialogHeader => 'Are you sure you want to remove this journey?';

  @override
  String get deleteDialogConfirmText => 'Remove Journey';

  @override
  String deleteDialogBody(String artistName) =>
      'Please consider sending your artist a healed photo first!';
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

  @override
  String get deleteDialogHeader => 'It doesn\'t look like you\'ve got anything left to do.';

  @override
  String get deleteDialogConfirmText => 'Remove Journey';

  @override
  String deleteDialogBody(String artistName) => 'We hope you enjoyed your tattoo journey';
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

  @override
  String get deleteDialogHeader => 'Invalid';

  @override
  String get deleteDialogConfirmText => 'Invalid';

  @override
  String deleteDialogBody(String artistName) => 'Invalid';
}
