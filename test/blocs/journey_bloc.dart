import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journey_bloc.dart';
import 'package:inkstep/blocs/journey_state.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';

class MockJourneysRepository extends JourneysRepository implements Mock {}

void main() {
  group('JourneyBloc', () {
    JourneyBloc journeyBloc;

    setUp(() {
      journeyBloc = JourneyBloc(journeysRepository: MockJourneysRepository());
    });

    test('initial state is unititialised', () {
      expect(journeyBloc.initialState, JourneyUninitialised());
    });
  });
}
