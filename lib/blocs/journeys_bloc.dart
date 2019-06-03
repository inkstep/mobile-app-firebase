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
      print("Hello");
      if (event.journey != null) {
        print("Hi");
        yield* _mapAddJourneysState(event);
      }
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneysState(event);
    }
  }

  Stream<JourneysState> _mapAddJourneysState(AddJourney event) async* {
    print("1");
    if (currentState is JourneyLoaded) {
      print("2");
      final JourneyLoaded loadedState = currentState;
      final updatedJourneys = List<Journey>.from(loadedState.journeys)..add(event.journey);
      yield JourneyLoaded(journeys: updatedJourneys);
      _saveJourneys([event.journey]);
    } else if (currentState is JourneysUninitialised) {
      final loadedJourneys = await _loadJourneys();
      final updatedJourneys = List<Journey>.from(loadedJourneys)..add(event.journey);
      yield JourneyLoaded(journeys: updatedJourneys);
    }
    _saveJourneys([event.journey]);
  }

  Stream<JourneysState> _mapLoadJourneysState(LoadJourneys event) async* {
    if (currentState is JourneysUninitialised) {
      final List<Journey> journeys = await _loadJourneys();
      yield JourneyLoaded(journeys: journeys);
    }
  }

  Future<List<Journey>> _loadJourneys() async {
    final List<Map<String, dynamic>> jsonJourneys = await journeysRepository.loadJourneys();
    return jsonJourneys.map((jsonJourney) => Journey.fromJson(jsonJourney)).toList();
  }

  void _saveJourneys(List<Journey> journeys) {
    print('delta');
    final journeysMap = journeys.map<Map<String, dynamic>>((j) => j.toJson()).toList();
    journeysRepository.saveJourneys(journeysMap);
  }
}
