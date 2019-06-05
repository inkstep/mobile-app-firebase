import 'package:bloc/bloc.dart';
import 'package:inkstep/models/journey_model.dart';
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
      if (event.journey != null) {
        print('1');
        yield* _mapAddJourneysState(event);
      }
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysState(event);
    }
  }

  Stream<JourneysState> _mapAddJourneysState(AddJourney event) async* {
    print('2');
    int userId;
    List<Journey> loadedJourneys;

    JourneysState journeyState = currentState;

    if (journeyState is JourneyError) {
      final JourneyError errorState = currentState;
      journeyState = errorState.prev;
    }

    print(journeyState);

    if (journeyState is JourneysNoUser) {
      userId = await journeysRepository.saveUser(event.user);
      print('userID=$userId');
      if (userId == -1) {
        yield JourneyError(prev: journeyState);
        return;
      }

      loadedJourneys = [event.journey];

      journeyState = JourneysWithUser(journeys: loadedJourneys, userId: userId);
    } else {
      final JourneysWithUser loadedState = journeyState;
      loadedJourneys = loadedState.journeys;
    }

    final bool success = await journeysRepository.saveJourneys(<Journey>[event.journey]);

    print('success=$success');

    if (success) {
      yield JourneysWithUser(journeys: [event.journey] + loadedJourneys, userId: userId);

      return;
    }

    yield JourneyError(prev: journeyState);
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    JourneysState journeysState = currentState;

    if (journeysState is JourneyError) {
      final JourneyError errorState = journeysState;
      journeysState = errorState.prev;
    }

    if (journeysState is JourneysNoUser) {
      yield JourneyError(prev: journeysState);
    } else if (currentState is JourneysWithUser) {
      final JourneysWithUser loadedState = journeysState;
      final List<Journey> journeys = await journeysRepository.loadJourneys();
      final combinedJourneys =
          Set<Journey>.from(loadedState.journeys).union(journeys.toSet()).toList();
      yield JourneysWithUser(journeys: combinedJourneys, userId: loadedState.userId);
    }
  }
}
