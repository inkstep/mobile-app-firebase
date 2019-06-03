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
    if (currentState is JourneyLoaded) {
      final JourneyLoaded loadedState = currentState;
      final updatedJourneys = List<Journey>.from(loadedState.journeys)..add(event.journey);
      yield JourneyLoaded(journeys: updatedJourneys);
      await journeysRepository.saveJourneys([event.journey]);
    }
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    if (currentState is JourneysUninitialised) {
      final List<Journey> journeys = await journeysRepository.loadJourneys();
      yield JourneyLoaded(journeys: journeys);
    }
  }
}
