import 'package:bloc/bloc.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:meta/meta.dart';

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

    int userId = -1;
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
      userId = journeysWithUser.user.id;
    }

    final JourneyEntity newJourney = JourneyEntity(
      userId: userId,
      availability: event.result.availability,
      deposit: event.result.deposit,
      mentalImage: event.result.mentalImage,
      position: event.result.position,
      size: event.result.size,
      noImages: 0, // TODO(DJRHails): Pass in images here
    );

    if (!await journeysRepository.saveJourneys(<JourneyEntity>[newJourney])) {
      print('Failed to save journeys');
      yield JourneyError(prev: currentState);
    } else {
      yield JourneysWithUser(
        cards: await _getCardsFromJourneys(
            [newJourney] + await journeysRepository.loadJourneys(userId: userId)),
        user: journeysRepository.getUser(userId),
      );
    }
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    JourneysState journeysState = currentState;

    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      yield errorState.prev;
    }

    if (journeysState is JourneysNoUser) {
      final cards = await _getCards(0);
      print('Loaded initial cards with fake user 0: $cards');

      yield JourneysWithUser(
          user: User(id: 0, name: 'test.name', email: 'test.email'), cards: cards);
    } else if (currentState is JourneysWithUser) {
      final JourneysWithUser userState = currentState;

      final cards = await _getCards(userState.user.id);
      print('Reloaded cards for user ${userState.user.id}: $cards');

      yield JourneysWithUser(cards: cards, user: userState.user);
    }
  }

  Future<List<CardModel>> _getCards(int userId) async {
    final List<JourneyEntity> journeys = await journeysRepository.loadJourneys(userId: userId);
    return _getCardsFromJourneys(journeys);
  }

  Future<List<CardModel>> _getCardsFromJourneys(List<JourneyEntity> list) async {
    List<CardModel> cards = <CardModel>[];
    for (JourneyEntity je in list) {
      final Artist artist = await journeysRepository.getArtist(je.artistId);
      cards.add(CardModel(je.mentalImage, artist.name));
    }
    return cards;
  }
}
