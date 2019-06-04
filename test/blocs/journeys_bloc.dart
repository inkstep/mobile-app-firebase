import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';

class MockJourneysRepository extends Mock implements JourneysRepository {}

void main() {
  group('JourneysBloc', () {
    JourneysBloc journeysBloc;
    MockJourneysRepository repo;

    final Journey j1 = Journey(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      email: 'email',
    );

    final Journey j2 = Journey(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      email: 'email',
    );

    setUp(() {
      repo = MockJourneysRepository();
      journeysBloc = JourneysBloc(journeysRepository: repo);
    });

    test('initial state is unititialised', () {
      expect(journeysBloc.initialState, JourneysUninitialised());
    });

    test('add journey event with missing journey does nothing', () async {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysUninitialised(),
            JourneysLoaded(journeys: <Journey>[], user: null),
          ],
        ),
      );

      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<Journey>[]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(user: null, journey: null));
    });

    test('add journey event should emit with the additional journey in the front', () {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysUninitialised(),
            JourneysLoaded(journeys: <Journey>[j1], user: null),
            JourneysLoaded(journeys: <Journey>[j2, j1], user: null),
          ],
        ),
      );

      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<Journey>[j1]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(user: null, journey: j2));
    });
  });
}
