import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/empty_journey_entity.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:palette_generator/palette_generator.dart';

import 'journeys_event.dart';
import 'journeys_state.dart';

class JourneysBloc extends Bloc<JourneysEvent, JourneysState> {
  JourneysBloc({@required this.journeysRepository});

  final JourneysRepository journeysRepository;

  @override
  JourneysState get initialState => JourneysNoUser();

  @override
  Stream<JourneysState> mapEventToState(JourneysEvent event) async* {
    if (event is AddJourney && event.result != null) {
      yield* _mapAddJourneysState(event);
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysState(event);
    } else if (event is ShownFeatureDiscovery) {
      yield* _mapShownFeatureDiscoveryState(event);
    } else if (event is DialogJourneyEvent) {
      yield* _mapDialogState(event);
    }
  }

  Stream<JourneysState> _mapAddJourneysState(AddJourney event) async* {
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
    bool firstTime;
    if (currentState is JourneysNoUser) {
      final UserEntity user = UserEntity(name: event.result.name, email: event.result.email);
      userId = await journeysRepository.saveUser(user);
      print('userID=$userId');
      if (userId == -1) {
        yield JourneyError(prev: currentState);
        return;
      }
    } else if (currentState is JourneysWithUser) {
      final JourneysWithUser journeysWithUser = currentState;
      user = journeysWithUser.user;
      userId = user.id;
      firstTime = journeysWithUser.firstTime;
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

      yield JourneysWithUser(cards: cards, user: user, firstTime: firstTime ?? true);
      print(JourneysWithUser(cards: cards, user: user, firstTime: firstTime ?? true));
      return;
    }
  }

  Stream<JourneysState> _mapShownFeatureDiscoveryState(ShownFeatureDiscovery event) async* {
    if (currentState is JourneysWithUser) {
      final JourneysWithUser jwu = currentState;
      yield JourneysWithUser(user: jwu.user, cards: jwu.cards, firstTime: false);
    }
  }

  Stream<JourneysState> _mapDialogState(DialogJourneyEvent event) async* {
    assert(currentState is JourneysWithUser);
    if (event is QuoteAccepted) {
      await journeysRepository.updateStage(AppointmentOfferReceived(null), event.journeyId);
    } else if (event is QuoteDenied || event is DateDenied) {
      // TODO(DJRHails): Should have deny state / warning
    } else if (event is DateAccepted) {
      await journeysRepository.updateStage(BookedIn(null), event.journeyId);
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

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    final JourneysState journeysState = currentState;

    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      yield errorState.prev;
    }

    if (currentState is JourneysNoUser) {
      const userId = 0;
      final User user = await journeysRepository.getUser(userId);
      print('Loading with fake user 0: $user');
      final cards = await _getCards(0);
      print('Loaded initial cards with fake user 0: $cards');

      yield JourneysWithUser(
        user: user,
        cards: cards,
        firstTime: true,
      );
    } else if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;

      final cards = await _getCards(userState.user.id);
      print('Reloaded cards for user ${userState.user.id}: $cards');

      yield JourneysWithUser(
          cards: cards, user: userState.user, firstTime: userState.firstTime ?? true);
    }
  }

  Future<List<Future<CardModel>>> _getCards(int userId) async {
    print('Loading cards for $userId');
    final List<JourneyEntity> journeys = await journeysRepository.loadJourneys(userId: userId);
    print('Done that...');
    return _getCardsFromJourneys(journeys);
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

    DateTime bookedDate;

    if (je.stage is BookedIn) {
      final BookedIn stage = je.stage;
      bookedDate = stage.bookedDate;
    }

    return CardModel(
      description: je.mentalImage,
      artistName: artist.name,
      bodyLocation: je.position,
      size: je.size,
      images: images,
      stage: je.stage,
      index: idx,
      palette: palette,
      journeyId: je.id,
      bookedDate: bookedDate,
      availability: je.availability,
      placement: je.position,
      size: je.size,
    );
  }
}
