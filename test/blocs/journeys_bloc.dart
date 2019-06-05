import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/models/form_result_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';

class MockJourneysRepository extends Mock implements JourneysRepository {}

void main() {
  group('JourneysBloc', () {
    JourneysBloc journeysBloc;
    MockJourneysRepository repo;

    final JourneyEntity j1 = JourneyEntity(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      email: 'email',
      userId: 0,
    );

    final JourneyEntity j2 = JourneyEntity(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      email: 'email',
      userId: 0,
    );

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
            JourneysWithUser(cards: <JourneyEntity>[], user: -1),
          ],
        ),
      );

      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<JourneyEntity>[]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(result: null));
    });

    test('add journey event should emit with the additional journey in the front', () {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysNoUser(),
            JourneysWithUser(cards: <JourneyEntity>[j1], user: 0),
            JourneysWithUser(cards: <JourneyEntity>[j2, j1], user: 0),
          ],
        ),
      );

      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<JourneyEntity>[j1]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(
          result: FormResult(
        position: j2.position,
        availability: j2.availability,
        email: null,
        mentalImage: null,
        name: null,
        size: null,
      )));
    });
  });
}
