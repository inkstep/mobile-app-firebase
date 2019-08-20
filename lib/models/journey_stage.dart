import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/ui/components/date_block.dart';
import 'package:inkstep/ui/pages/journeys/sentiment_row.dart';
import 'package:inkstep/ui/pages/single_journey_screen.dart';
import 'package:inkstep/utils/screen_navigator.dart';

import 'card_model.dart';

abstract class JourneyStage extends Equatable {
  JourneyStage([List<dynamic> props = const <dynamic>[]]) : super(props);

  factory JourneyStage.fromInt(int stage) {
    if (stage != 0) {
      return Finished();
    }
    return WaitingForQuote();
  }

  // TODO(mm): this
  /*factory JourneyStage.fromInt(int stage) {
    switch (stage) {
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
  }*/

  int get progress;

  bool get userActionRequired;

  int get numberRepresentation;

  IconData get icon;

  String get deleteDialogHeader;

  String get deleteDialogConfirmText;

  String deleteDialogBody(String artistName);

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
            (quote.start != quote.end)
                ? '£${quote.start}-£${quote.end}.'
                : '£${quote.start}.',
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
      onAcceptance: () {
        // TODO(mm): this
        // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
        // journeyBloc.dispatch(QuoteAccepted(card.journey.id));
        // card.stage = WaitingForAppointmentOffer(card.quote);
        final ScreenNavigator nav = sl.get<ScreenNavigator>();
        nav.pop(context);
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
          child: DateBlock(date: appointmentDate),
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
    return SentimentRow(onAcceptance: () {
      // TODO(mm): this
      // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
      // journeyBloc.dispatch(DateAccepted(card.journeyId));
      // card.stage = BookedIn(card.bookedDate, card.quote);
      // final ScreenNavigator nav = sl.get<ScreenNavigator>();
      // nav.pop(context);
    }, onDenial: () {
      // TODO(mm): this
      // final JourneysBloc journeyBloc = BlocProvider.of<JourneysBloc>(context);
      // journeyBloc.dispatch(DateDenied(card.journey.id));
      // final ScreenNavigator nav = sl.get<ScreenNavigator>();
      // nav.pop(context);
    });
  }
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
        // TODO(mm): this
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
