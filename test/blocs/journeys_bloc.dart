import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/card_model.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MockJourneysRepository extends Mock implements JourneysRepository {}

void main() {
  group('JourneysBloc', () {
    JourneysBloc journeysBloc;
    MockJourneysRepository repo;
    final CardModel c1 = CardModel('Star', 'Ricky');
    final JourneyEntity j1 = JourneyEntity(
      userId: 0,
      artistId: 0,
      mentalImage: 'Star',
      size: '',
      position: '',
      availability: '',
      deposit: '',
      noImages: 0,
    );

    final CardModel c2 = CardModel('Flower', 'Ricky');
    final JourneyEntity j2 = JourneyEntity(
      userId: 0,
      artistId: 0,
      mentalImage: 'Flower',
      size: '',
      position: '',
      availability: '',
      deposit: '',
      noImages: 0,
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
            JourneysWithUser(cards: <CardModel>[], user: testUser),
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
            JourneysWithUser(cards: <CardModel>[c1], user: testUser),
            JourneysWithUser(cards: <CardModel>[c2, c1], user: testUser),
          ],
        ),
      );

      final responses = [
        Future.value(<JourneyEntity>[j1]),
        Future.value(<JourneyEntity>[j2, j1])
      ];
      when(repo.loadJourneys(userId: 0)).thenAnswer((_) => responses.removeAt(0));

      when(repo.getArtist(0)).thenAnswer(
        (_) => Future.value(
              Artist(
                name: 'Ricky',
                email: 'someemail',
                studio: 'scm',
              ),
            ),
      );
      when(repo.saveJourneys(any)).thenAnswer((_) => Future.value(1));

      journeysBloc.dispatch(LoadJourneys());

      journeysBloc.dispatch(
        AddJourney(
          result: FormResult(
            position: '',
            availability: '',
            mentalImage: 'Flower',
            name: testUser.name,
            size: '',
            deposit: '',
            email: testUser.email,
            images: <Asset>[],
          ),
        ),
      );
    });
  });
}
