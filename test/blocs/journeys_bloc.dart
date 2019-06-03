import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';

class MockJourneysRepository extends JourneysRepository implements Mock {}

void main() {
  group('JourneysBloc', () {
    test('initial state is unititialised', () {
      final MockJourneysRepository journeysRepository = MockJourneysRepository();
      final JourneysBloc journeyBloc = JourneysBloc(journeysRepository: journeysRepository);
      expect(journeyBloc.initialState, JourneysUninitialised());
    });

    /*test('add journey event with missing journey does nothing', () async {
      MockJourneysRepository journeysRepository = MockJourneysRepository();
      JourneysBloc journeyBloc = JourneysBloc(journeysRepository: journeysRepository);

      when(journeysRepository.loadJourneys()).thenAnswer((_) => Future.value(<Map<String, dynamic>>[]));

      expectLater(journeyBloc.state, emitsInOrder(<JourneysState>[JourneysUninitialised(), JourneyLoaded(journeys: <Journey>[])]));

      journeyBloc.dispatch(LoadJourneys());
      journeyBloc.dispatch(AddJourney(null));
    });

    test('add journey event should emit the the current state plus the additional journey', () {
      MockJourneysRepository journeysRepository = MockJourneysRepository();
      JourneysBloc journeyBloc = JourneysBloc(journeysRepository: journeysRepository);

      final Journey testJourney = Journey(
          availability: 'availability',
          deposit: 'deposit',
          size: 'size',
          artistName: 'artistName',
          name: 'name',
          position: 'position',
          mentalImage: 'mentalImage',
          email: 'email');
      expectLater(journeyBloc.state, emits(JourneyLoaded(journeys: [testJourney])));

      journeyBloc.dispatch(AddJourney(testJourney));
    });*/
  });
}
