import 'package:flutter_test/flutter_test.dart';
import 'package:inkstep/blocs/journeys_bloc.dart';
import 'package:inkstep/blocs/journeys_event.dart';
import 'package:inkstep/blocs/journeys_state.dart';
import 'package:inkstep/models/journey_info_model.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:mockito/mockito.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class MockJourneysRepository extends Mock implements JourneysRepository {}

void main() {
  group('JourneysBloc', () {
    JourneysBloc journeysBloc;
    MockJourneysRepository repo;

    final JourneyInfo jInfo = JourneyInfo(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      images: <Asset>[],
      userEmail: 'j@e.com',
      userName: 'jimmy',
    );

    final Journey j = Journey(
      availability: 'availability',
      deposit: 'deposit',
      size: 'size',
      position: 'position',
      mentalImage: 'mentalImage',
      email: 'j@e.com',
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
            JourneysWithUser(journeys: <Journey>[], userId: -1),
          ],
        ),
      );

      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<Journey>[]));

      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(journeyInfo: null));
    });

    test('add journey event should emit with the additional journey in the front', () {
      expect(
        journeysBloc.state,
        emitsInOrder(
          <JourneysState>[
            JourneysNoUser(),
            JourneysWithUser(journeys: <Journey>[j], userId: 2),
            JourneysWithUser(journeys: <Journey>[j, j], userId: null),
          ],
        ),
      );

      when(repo.saveJourneys(any)).thenAnswer((_) => Future.value(2));
      when(repo.loadJourneys()).thenAnswer((_) => Future.value(<Journey>[j]));
      when(repo.saveUser(any, any)).thenAnswer((_) => Future.value(2));

      journeysBloc.dispatch(AddJourney(journeyInfo: jInfo));
      journeysBloc.dispatch(LoadJourneys());
      journeysBloc.dispatch(AddJourney(journeyInfo: jInfo));
    });
  });
}
