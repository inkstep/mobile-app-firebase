import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MockJourneysRepository extends Mock implements JourneysRepository {}

void main() {
  group('JourneysBloc', () {
    JourneysBloc journeysBloc;
    MockJourneysRepository repo;

    final Future<CardModel> c1 = Future.value(CardModel(
      description: 'Star',
      artistId: 1,
      artistName: 'Ricky',
      userId: 0,
      bodyLocation: 'Butt hole',
      size: '15 cm by 5cm',
      quote: null,
      images: [],
      stage: WaitingForQuote(),
      index: 0,
      palette: null,
      journeyId: null,
      bookedDate: DateTime.parse('2019-06-18 10:00:00'),
    ));
    final JourneyEntity j1 = JourneyEntity(
      id: 1,
      userId: 0,
      artistId: 0,
      mentalImage: 'Star',
      size: '',
      position: '',
      availability: '',
      noImages: 0,
      stage: WaitingForQuote(),
    );

    final Future<CardModel> c2 = Future.value(CardModel(
      description: 'Flower',
      artistId: 1,
      artistName: 'Ricky',
      userId: 0,
      bodyLocation: 'Butt hole',
      size: '15 cm by 5cm',
      quote: null,
      images: [],
      stage: WaitingForQuote(),
      index: 1,
      palette: null,
      journeyId: null,
      bookedDate: DateTime.parse('2019-06-18 10:00:00'),
    ));

    final JourneyEntity j2 = JourneyEntity(
      id: 1,
      userId: 0,
      artistId: 0,
      mentalImage: 'Flower',
      size: '',
      position: '',
      availability: '',
      noImages: 0,
      stage: WaitingForQuote(),
    );

    final User testUser = User(id: 0, name: 'test.name', email: 'test.email');

    setUp(() {
      repo = MockJourneysRepository();
      journeysBloc = JourneysBloc(journeysRepository: repo);
    });

    test('initial state is unititialised', () {
      expect(journeysBloc.initialState, JourneysNoUser());
    });

    test('add journey event with missing journey does nothing', () async {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysNoUser(),
            JourneysWithUser(cards: <Future<CardModel>>[], user: testUser, firstTime: true),
          ],
        ),
      );

      when(repo.loadJourneys(userId: 0)).thenAnswer((_) => Future.value(<JourneyEntity>[]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(result: null));
    });

    test('add journey event should emit with the additional journey in the front', () {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysNoUser(),
            JourneysWithUser(cards: <Future<CardModel>>[c1], user: testUser, firstTime: true),
            JourneysWithUser(cards: <Future<CardModel>>[c2, c1], user: testUser, firstTime: true),
          ],
        ),
      );

      final responses = [
        Future.value(<JourneyEntity>[j1]),
        Future.value(<JourneyEntity>[j2, j1])
      ];
      when(repo.loadJourneys(userId: 0)).thenAnswer((_) => responses.removeAt(0));

      when(repo.loadArtist(0)).thenAnswer(
        (_) => Future.value(
              ArtistEntity(
                name: 'Ricky',
                email: 'someemail',
                studioID: 1,
                artistID: 1,
              ),
            ),
      );
      when(repo.saveJourneys(any)).thenAnswer((_) => Future.value(1));

      journeysBloc.dispatch(LoadJourneys());

      journeysBloc.dispatch(
        AddJourney(
          result: FormResult(
            artistID: 101,
            position: '',
            availability: '',
            description: 'Flower',
            name: testUser.name,
            size: '',
            email: testUser.email,
            images: <Asset>[],
            style: 'Blackwork'
          ),
        ),
      );
    });
  });
}
