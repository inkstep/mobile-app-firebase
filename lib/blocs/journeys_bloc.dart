import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'journeys_event.dart';
import 'journeys_state.dart';

class JourneysBloc extends Bloc<JourneysEvent, JourneysState> {
  JourneysBloc({@required this.journeysRepository});

  final JourneysRepository journeysRepository;

  @override
  JourneysState get initialState => JourneysNoUser();

  @override
  Stream<JourneysState> mapEventToState(JourneysEvent event) async* {
    if (event is AddJourney) {
      if (event.result != null) {
        yield* _mapAddJourneysState(event);
      }
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysState(event);
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
    List<CardModel> oldCards = <CardModel>[];
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
      oldCards = journeysWithUser.cards;
    }

    // Now send the corresponding journey
    final JourneyEntity newJourney = _journeyEntityFromFormResult(user?.id ?? userId, -1, event
        .result);

    print('About to save the journey: $newJourney');
    final int journeyId = await journeysRepository.saveJourneys(<JourneyEntity>[newJourney]);
    if (journeyId == -1) {
      print('Failed to save journeys');
      yield JourneyError(prev: currentState);
    } else {
      newJourney.id = journeyId;

      for (Asset img in event.result.images) {
        await journeysRepository.saveImage(journeyId, img);
      }

      print('Successfully saved journey');
      final List<CardModel> cards = await _getCards(user?.id ?? userId);
      print('Successfully loaded cards in for ${user?.id ?? userId}: $cards');
      user = user ?? journeysRepository.getUser(userId);
      print('Successfully loaded user $user');

      print('Merging in with oldCards: $oldCards');
      yield JourneysWithUser(
        cards: _mergeCards(cards, oldCards),
        user: user,
      );
      print(JourneysWithUser(
        cards: cards,
        user: user,
      ));
      return;
    }
  }

  JourneyEntity _journeyEntityFromFormResult(int userId, int id, FormResult result) {
    return JourneyEntity(
      id: id,
      userId: userId,
      availability: result.availability,
      deposit: result.deposit,
      mentalImage: result.mentalImage,
      position: result.position,
      size: result.size,
      noImages: result.images.length,
    );
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    final JourneysState journeysState = currentState;

    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      yield errorState.prev;
    }

    if (currentState is JourneysNoUser) {
      print('Loading initial cards with fake user 0');
      final cards = await _getCards(0);
      print('Loaded initial cards with fake user 0: $cards');

      yield JourneysWithUser(
          user: User(id: 0, name: 'test.name', email: 'test.email'), cards: cards);
    } else if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;

      final cards = await _getCards(userState.user.id);
      print('Reloaded cards for user ${userState.user.id}: $cards');

      yield JourneysWithUser(cards: _mergeCards(userState.cards, cards), user: userState.user);
    }
  }

  List<CardModel> _mergeCards(List<CardModel> c1, List<CardModel> c2) {
    return Set<CardModel>.from(c1).union(c2.toSet()).toList();
  }

  Future<List<CardModel>> _getCards(int userId) async {
    print('Loading cards for $userId');
    final List<JourneyEntity> journeys = await journeysRepository.loadJourneys(userId: userId);
    return _getCardsFromJourneys(journeys);
  }

  Future<List<CardModel>> _getCardsFromJourneys(List<JourneyEntity> list) async {
    final List<CardModel> cards = <CardModel>[];
    for (JourneyEntity je in list) {
      final Artist artist = await journeysRepository.getArtist(je.artistId);
      final List<Image> images = await journeysRepository.getImages(je.id);
      cards.add(CardModel(je.mentalImage, artist.name, images));
    }
    print('Converted JourneyEntity $list to $cards');
    return cards;
  }
}
