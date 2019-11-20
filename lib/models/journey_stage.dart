import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/date_block.dart';
import 'package:inkstep/ui/pages/journeys/sentiment_row.dart';
import 'package:inkstep/ui/pages/single_journey_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'card.dart';

abstract class JourneyStage extends Equatable {
  JourneyStage([List<dynamic> props = const <dynamic>[]]) : super(props);

  factory JourneyStage.fromMap(Map<String, dynamic> map) {
    switch (map['stage']) {
      case 0:
        return WaitingForQuote();
      case 1:
      case 2:
      case 8:
        return _hasQuote(map) ? JourneyStageWithQuote.fromMap(map) : InvalidStage();
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return _hasDate(map) ? JourneyStageWithBooking.fromMap(map) : InvalidStage();
      case 9:
        return MessageStage();
      default:
        return InvalidStage();
    }
  }

  static bool _hasQuote(Map<String, dynamic> map) {
    return map.containsKey('quoteLower') && map.containsKey('quoteUpper');
  }

  static bool _hasDate(Map<String, dynamic> map) {
    return _hasQuote(map) && map.containsKey('date');
  }

  bool get userActionRequired;

  int get numberRepresentation;

  IconData get icon;

  String get deleteDialogHeader;

  String get deleteDialogConfirmText;

  String deleteDialogBody(String artistName);

  Map<String, dynamic> toMap() {
    return <String , dynamic>{
      'stage': numberRepresentation,
    };
  }

  Widget buildStageWidget(BuildContext context, CardModel card) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text('${toString()}')),
    );
  }

  Widget buildDismissStageWidget(BuildContext context, CardModel card) {
    return null;
  }
}

abstract class JourneyStageWithQuote extends JourneyStage {
  JourneyStageWithQuote(this.quote);

  factory JourneyStageWithQuote.fromMap(Map<String, dynamic> map) {
    final TextRange quote = TextRange(start: map['quoteLower'], end: map['quoteUpper']);
    switch (map['stage']) {
      case 1:
        return QuoteReceived(quote);
      case 2:
        return WaitingForAppointmentOffer(quote);
      case 8:
        return WaitingList(quote);
      default:
        return null;
    }
  }

  final TextRange quote;

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll(
      <String, dynamic>{
        'quoteLower': quote.start,
        'quoteUpper': quote.end,
      }
    );
    return map;
  }
}

abstract class JourneyStageWithBooking extends JourneyStageWithQuote {
  JourneyStageWithBooking(TextRange quote, this.date) : super(quote);

  factory JourneyStageWithBooking.fromMap(Map<String, dynamic> map) {
    final TextRange quote = TextRange(start: map['quoteLower'], end: map['quoteUpper']);
    final DateTime date = DateTime.parse(map['date']);
    switch (map['stage']) {
      case 3:
        return AppointmentOfferReceived(quote, date);
      case 4:
        return BookedIn(quote, date);
      case 5:
        return Aftercare(quote, date);
      case 6:
        return Healed(quote, date);
      case 7:
        return Finished(quote, date);
      default:
        return null; // TODO(mm): use mixin for having 'with booking', 'with quote' to avoid null here
    }
  }

  final DateTime date;

  @override
  Map<String, dynamic> toMap() {
    final map = super.toMap();
    map.addAll(
        <String, dynamic>{
          'date': date.toIso8601String(),
        }
    );
    return map;
  }
}

class MessageStage extends JourneyStage {
  @override
  // TODO(mm): implement deleteDialogConfirmText
  String get deleteDialogConfirmText => null;

  @override
  // TODO(mm): implement deleteDialogHeader
  String get deleteDialogHeader => null;

  @override
  IconData get icon => Icons.message;

  @override
  // TODO(mm): implement numberRepresentation
  int get numberRepresentation => 9;

  @override
  // TODO(mm): implement userActionRequired
  bool get userActionRequired => null;

  @override
  String deleteDialogBody(String artistName) {
    // TODO(mm): implement deleteDialogBody
    return null;
  }
}

class WaitingForQuote extends JourneyStage {
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

  @override
  Widget buildStageWidget(BuildContext context, CardModel card) {
    return Column(
      children: <Widget>[
        Text(
          'Hey! ${card.artist.name.split(' ').first} wants to do your tattoo! They think this is a fair estimate.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (quote.start != quote.end) ? '£${quote.start}-£${quote.end}.' : '£${quote.start}.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline,
          ),
        ),
        Text(
          'You happy with this?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
      ],
    );
  }

  @override
  Widget buildDismissStageWidget(BuildContext context, CardModel card) {
    return SentimentRow(
      onAcceptance: () async {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.pop(context);
        final Map<String, int> toUpdate = {
          'stage': 3,
        };
        card.journey.stage = WaitingForAppointmentOffer(quote);
        final DocumentReference journey = Firestore.instance.collection('journeys').document(card.journey.id);
        await journey.updateData(toUpdate);
      },
      onDenial: () {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.pop(context);
        showDialog<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return DeleteJourneyDialog(
              card: card,
              doublePop: false,
            );
          },
        );
      },
    );
  }
}

class WaitingForAppointmentOffer extends JourneyStageWithQuote {
  WaitingForAppointmentOffer(TextRange quote) : super(quote);
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

class AppointmentOfferReceived extends JourneyStageWithBooking {
  AppointmentOfferReceived(TextRange quote, DateTime booking) : super(quote, booking);
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

  @override
  Widget buildStageWidget(BuildContext context, CardModel card) {
    return Column(
      children: <Widget>[
        Text(
          'Hey! ${card.artist.name.split(' ').first} is excited to do your appointment:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          child: DateBlock(date: date),
        ),
        Text(
          'You happy with this?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
      ],
    );
  }

  @override
  Widget buildDismissStageWidget(BuildContext context, CardModel card) {
    return SentimentRow(onAcceptance: () async {
      // TODO(mm): accept appointment cloud function
      // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
      // journeyBloc.dispatch(DateAccepted(card.journeyId));
      // card.stage = BookedIn(card.date, card.quote);
       final ScreenNavigator nav = sl.get<ScreenNavigator>();
       nav.pop(context);
       final Map<String, int> toUpdate = {
         'stage': 4,
       };
       card.journey.stage = BookedIn(quote, date);
       final DocumentReference journey = Firestore.instance.collection('journeys').document(card.journey.id);
       await journey.updateData(toUpdate);

    }, onDenial: () {
      // TODO(mm): reject appointment cloud function
      // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
      // journeyBloc.dispatch(DateDenied(card.journey.id));
       final ScreenNavigator nav = sl.get<ScreenNavigator>();
       nav.pop(context);
    });
  }
}

class BookedIn extends JourneyStageWithBooking {
  BookedIn(TextRange quote, DateTime date) : super(quote, date);
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

class Aftercare extends JourneyStageWithBooking {
  Aftercare(TextRange quote, DateTime appointmentDate) : super(quote, appointmentDate);

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

class Healed extends JourneyStageWithBooking {
  Healed(TextRange quote, DateTime date) : super(quote, date);

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

  @override
  Widget buildStageWidget(BuildContext context, CardModel card) {
    return Column(
      children: <Widget>[
        Text(
          'Hey! Congratulations! You tattoo is nice an healed!!!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
        ),
        Text(
          'You know, you should send a sweet pic of your healed tattoo to your tattoo artist!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle,
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
        ),
        Icon(Icons.camera_enhance),
        Container(
          padding: const EdgeInsets.all(16.0),
        ),
      ],
    );
  }

  @override
  Widget buildDismissStageWidget(BuildContext context, CardModel card) {
    return SentimentRow(
      onAcceptance: () async {
        // TODO(mm): send healed photo cloud function
        // final File image = await ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 800, maxWidth: 800);
        // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
        // journeyBloc.dispatch(SendPhoto(image, card.userId, card.artistId, card.journeyId));
        // card.stage = Finished();
        // final ScreenNavigator nav = sl.get<ScreenNavigator>();
        // nav.pop(context);
      },
      onDenial: () {
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.pop(context);
      },
    );
  }
}

class Finished extends JourneyStageWithBooking {
  Finished(TextRange quote, DateTime date) : super(quote, date);

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
