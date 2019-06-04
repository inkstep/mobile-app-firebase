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
  JourneysState get initialState => JourneysUninitialised();

  @override
  Stream<JourneysState> mapEventToState(JourneysEvent event) async* {
    if (event is AddJourney) {
      if (event.journey != null) {
        yield* _mapAddJourneysState(event);
      }
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysState(event);
    }
  }

  Stream<JourneysState> _mapAddJourneysState(AddJourney event) async* {
    if (currentState is JourneysLoaded) {
      await journeysRepository.saveUser(event.user);
    }

    if (currentState is JourneysLoaded || currentState is JourneysUninitialised) {
      List<Journey> loadedJourneys;
      if (currentState is JourneysLoaded) {
        final JourneysLoaded loadedState = currentState;
        loadedJourneys = loadedState.journeys;
      } else if (currentState is JourneysUninitialised) {
        loadedJourneys = await journeysRepository.loadJourneys();
      }

      yield JourneysLoaded(journeys: [event.journey] + loadedJourneys);
      await journeysRepository.saveJourneys(<Journey>[event.journey]);
    }
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    if (currentState is JourneysUninitialised) {
      final List<Journey> journeys = await journeysRepository.loadJourneys();
      yield JourneysLoaded(journeys: journeys);
    } else if (currentState is JourneysLoaded) {
      final JourneysLoaded loadedState = currentState;
      final List<Journey> journeys = await journeysRepository.loadJourneys();
      final combinedJourneys =
          Set<Journey>.from(loadedState.journeys).union(journeys.toSet()).toList();
      yield JourneysLoaded(journeys: combinedJourneys);
    }
  }
}
