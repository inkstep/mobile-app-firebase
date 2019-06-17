import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:inkstep/di/service_locator.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/empty_journey_entity.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:inkstep/utils/screen_navigator.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'journeys_event.dart';
import 'journeys_state.dart';

class JourneysBloc extends Bloc<JourneysEvent, JourneysState> {
  JourneysBloc({
    @required this.journeysRepository,
  }) : firebase = FirebaseMessaging() {
    print('configuring firebase');

    if (Platform.isIOS) {
      // iOS Specific
      firebase.requestNotificationPermissions(
          const IosNotificationSettings(sound: true, badge: true, alert: true));
      firebase.onIosSettingsRegistered.listen((
          IosNotificationSettings settings) {
        print('Settings registered: $settings');
      });
    }

    firebase.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        _handleDataMessage(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
        _handleDataMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
        _handleDataMessage(message);
      },
    );
  }

  final FirebaseMessaging firebase;
  final JourneysRepository journeysRepository;

  @override
  JourneysState get initialState => JourneysNoUser();

  @override
  Stream<JourneysState> mapEventToState(JourneysEvent event) async* {
    if (event is AddJourney && event.result != null) {
      yield* _mapAddJourneysToState(event);
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysToState(event);
    } else if (event is LoadJourney) {
      yield* _mapLoadJourneyToState(event);
    } else if (event is ShownFeatureDiscovery) {
      yield* _mapShownFeatureDiscoveryToState(event);
    } else if (event is DialogJourneyEvent) {
      yield* _mapDialogToState(event);
    } else if (event is LoadUser) {
      yield* _mapLoadUserToState(event);
    } else if (event is SendPhoto) {
      yield* _mapSendPhotoToState(event);
    } else if (event is RemoveJourney) {
      yield* _mapRemoveJourneyToState(event);
    } else if (event is LogOut) {
      yield* _mapLogOutState(event);
    } else if (event is AddUser) {
      yield* _mapAddUserToState(event);
    }
  }

  Stream<JourneysState> _mapLoadJourneyToState(LoadJourney event) async* {
    if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;

      final List<CardModel> loadedCards = await Future.wait<CardModel>(userState.cards);

      final CardModel correctCard = loadedCards.firstWhere(
        (card) => card.journeyId == event.journeyId,
      );

      final card = await _getCard(event.journeyId, correctCard.index);

      print('Reloaded ${card.index}th card for user ${userState.user.id}: $card');

      final reloadedCards = loadedCards
          .map((c) => c.journeyId == event.journeyId ? Future.value(card) : Future.value(c))
          .toList();

      yield JourneysWithUser(
        cards: reloadedCards,
        user: userState.user,
        firstTime: userState.firstTime ?? true,
      );
    } else {
      print('Trying to call Load Journey ${event.journeyId} when not authenticated with a user.');
    }
  }

  Stream<JourneysState> _mapAddJourneysToState(AddJourney event) async* {
    if (currentState is JourneyError) {
      print('Adding when in Error state');
      final JourneyError errorState = currentState;
      yield errorState.prev;
      return;
    }

    print('Adding a Journey when in $currentState');

    // Setup User if not already done
    int userId = -1;
    User user;
    bool firstTime = true;
    print('doing a firstTime thing');
    if (currentState is JourneysNoUser) {
      final String pushToken = await firebase.getToken();

      final UserEntity user = UserEntity(
        name: event.result.name,
        email: event.result.email,
        token: pushToken,
      );
      userId = await journeysRepository.saveUser(user);
      print('userID=$userId');
      if (userId == -1) {
        yield JourneyError(prev: currentState);
        return;
      }
    } else if (currentState is JourneysWithUser) {
      print('Entered firstTime setting');
      final JourneysWithUser journeysWithUser = currentState;
      user = journeysWithUser.user;
      userId = user.id;
      final prefs = await SharedPreferences.getInstance();
      firstTime = prefs.getBool('firstTime');
      prefs.setInt('userId', userId);
      print('firstTime is set to: $firstTime');
    }

    // Now send the corresponding journey
    final EmptyJourneyEntity newJourney = _emptyJourneyEntityFromFormResult(userId, event.result);

    print('About to save the journey: $newJourney');
    final int journeyId = await journeysRepository.saveJourneys(<EmptyJourneyEntity>[newJourney]);
    if (journeyId == -1) {
      print('Failed to save journeys');
      yield JourneyError(prev: currentState);
    } else {
      for (Asset img in event.result.images) {
        await journeysRepository.saveImage(journeyId, img);
      }

      print('Successfully saved journey');
      final List<Future<CardModel>> cards = await _getCards(user?.id ?? userId);
      print('Successfully loaded cards in for ${user?.id ?? userId}: $cards');
      user = user ?? await journeysRepository.getUser(userId);
      print('Successfully loaded user $user');

      yield JourneysWithUser(cards: cards, user: user, firstTime: firstTime); //?? true);
      print(JourneysWithUser(cards: cards, user: user, firstTime: firstTime)); //?? true));
      return;
    }
  }

  Stream<JourneysState> _mapShownFeatureDiscoveryToState(ShownFeatureDiscovery event) async* {
    if (currentState is JourneysWithUser) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool('firstTime', false);
      print('firstTime set to false');
      final JourneysWithUser jwu = currentState;
      yield JourneysWithUser(user: jwu.user, cards: jwu.cards, firstTime: false);
    }
  }

  Stream<JourneysState> _mapDialogToState(DialogJourneyEvent event) async* {
    assert(currentState is JourneysWithUser);
    if (event is QuoteAccepted) {
      await journeysRepository.updateStage(AppointmentOfferReceived(null, null), event.journeyId);
    } else if (event is QuoteDenied || event is DateDenied) {
      // TODO(DJRHails): Should have deny state / warning
    } else if (event is DateAccepted) {
      await journeysRepository.updateStage(BookedIn(null, null), event.journeyId);
    }
  }

  EmptyJourneyEntity _emptyJourneyEntityFromFormResult(int userId, FormResult result) {
    return EmptyJourneyEntity(
        userId: userId,
        artistId: result.artistID,
        availability: result.availability,
        mentalImage: result.mentalImage,
        position: result.position,
        size: result.size,
        noImages: result.images.length);
  }

  Stream<JourneysState> _mapLoadJourneysToState(LoadJourneys event) async* {
    final JourneysState journeysState = currentState;
    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      yield errorState.prev;
    }

    if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;

      final prefs = await SharedPreferences.getInstance();
      final bool firstTime = prefs.getBool('firstTime');
      prefs.setInt('userId', userState.user.id);

      final List<Future<CardModel>> oldCards = userState.cards;
      List<Future<CardModel>> cards = await _getCards(userState.user.id);

      cards = _mergeCards(cards, oldCards);

      print('Reloaded cards for user ${userState.user.id}: $cards');

      yield JourneysWithUser(cards: cards, user: userState.user, firstTime: firstTime ?? true);
    }
  }

  List<Future<CardModel>> _mergeCards(List<Future<CardModel>> c1, List<Future<CardModel>> c2) {
    return Set<Future<CardModel>>.from(c1).union(c2.toSet()).toList();
  }

  Stream<JourneysState> _mapLoadUserToState(LoadUser event) async* {
    final JourneysState journeysState = currentState;

    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      yield errorState.prev;
    }

    final prefs = await SharedPreferences.getInstance();
    final bool firstTime = prefs.getBool('firstTime');
    if (currentState is JourneysNoUser) {
      final userId = event.userId;
      prefs.setInt('userId', userId);
      final User user = await journeysRepository.getUser(userId);
      final cards = await _getCards(userId);

      yield JourneysWithUser(
        user: user,
        cards: cards,
        firstTime: firstTime,
      );
    }
  }

  Future<List<Future<CardModel>>> _getCards(int userId) async {
    print('Loading cards for $userId');
    final List<JourneyEntity> journeys = await journeysRepository.loadJourneys(userId: userId);
    print('Done that...');
    return _getCardsFromJourneys(journeys);
  }

  Future<CardModel> _getCard(int journeyId, int index) async {
    print('Updating card with $journeyId');
    final JourneyEntity journey = await journeysRepository.loadJourney(id: journeyId);
    print('Done that...');
    return _getCardFromJourney(journey, index);
  }

  List<Future<CardModel>> _getCardsFromJourneys(List<JourneyEntity> list) {
    final List<Future<CardModel>> cards = <Future<CardModel>>[];

    for (int idx = 0; idx < list.length; idx++) {
      cards.add(_getCardFromJourney(list[idx], idx));
    }
    print('Converted JourneyEntity $list to $cards');
    return cards;
  }

  Future<CardModel> _getCardFromJourney(JourneyEntity je, int idx) async {
    final List<Image> images = await journeysRepository.getImages(je.id);
    final ArtistEntity artist = await journeysRepository.loadArtist(je.artistId);

    final List<PaletteColor> palettes = <PaletteColor>[];
    for (ImageProvider img in images.map((img) => img.image)) {
      final PaletteGenerator palette = await PaletteGenerator.fromImageProvider(
        img,
        maximumColorCount: 15,
      );
      palettes.addAll(palette.paletteColors);
    }
    final palette = PaletteGenerator.fromColors(palettes);

    TextRange quote;

    if (je.stage is JourneyStageWithQuote) {
      final JourneyStageWithQuote stage = je.stage;
      quote = stage.quote;
    }

    DateTime bookedDate;

    if (je.stage is BookedIn) {
      final BookedIn stage = je.stage;
      bookedDate = stage.bookedDate;
    } else if (je.stage is Aftercare) {
      final Aftercare stage = je.stage;
      bookedDate = stage.appointmentDate;
    }

    return CardModel(
      description: je.mentalImage,
      artistId: artist.artistID,
      artistName: artist.name,
      userId: je.userId,
      bodyLocation: je.position,
      size: je.size,
      images: images,
      quote: quote,
      stage: je.stage,
      index: idx,
      palette: palette,
      journeyId: je.id,
      bookedDate: bookedDate,
    );
  }

  Stream<JourneysState> _mapLogOutState(LogOut event) async* {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', null);
    final ScreenNavigator nav = sl.get<ScreenNavigator>();
    nav.openOnboardingPage(event.context);
    yield JourneysNoUser();
  }

  Stream<JourneysState> _mapSendPhotoToState(SendPhoto event) async* {
    await journeysRepository.sendArtistPhoto(event.imageData, event.journeyId);
    await journeysRepository.updateStage(Finished(), event.journeyId);
  }

  Stream<JourneysState> _mapRemoveJourneyToState(RemoveJourney event) async* {
    journeysRepository.removeJourney(event.journeyId);
    if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;
      final List<CardModel> loadedCards = await Future.wait<CardModel>(userState.cards);

      // Create mutable copy to remove from
      final List<CardModel> mutableLoadedCards = List.from(loadedCards);
      mutableLoadedCards.removeWhere(
        (card) => card.journeyId == event.journeyId,
      );
      final reloadedCards = mutableLoadedCards.map((c) => Future.value(c)).toList();

      yield JourneysWithUser(
        cards: reloadedCards,
        user: userState.user,
        firstTime: userState.firstTime ?? true,
      );
    } else {
      yield currentState;
    }
  }

  void _handleDataMessage(Map<String, dynamic> message) {
    if (message['data']['journey'] != null) {
      dispatch(LoadJourney(int.parse(message['data']['journey'])));
    }
  }

  Stream<JourneysState> _mapAddUserToState(AddUser event) async* {
    final String pushToken = await firebase.getToken();
    final UserEntity user = UserEntity(
      name: event.name,
      email: '',
      token: pushToken,
    );
    final int userId = await journeysRepository.saveUser(user);
    print('userID=$userId');
    if (userId == -1) {
      yield JourneyError(prev: currentState);
    } else {
      final User userModel = User(id: userId, email: '', name: event.name);
      yield JourneysWithUser(cards: [], firstTime: true, user: userModel);
    }
  }
}
