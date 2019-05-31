import 'package:bloc/bloc.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:meta/meta.dart';

import 'journey_event.dart';
import 'journey_state.dart';

class JourneyBloc extends Bloc<JourneyEvent, JourneyState> {
  JourneyBloc({@required this.journeysRepository});

  final JourneysRepository journeysRepository;

  @override
  JourneyState get initialState => JourneyUninitialised();

  @override
  Stream<JourneyState> mapEventToState(
    JourneyEvent event,
  ) async* {
    if (event is AddJourney) {
      yield* _mapAddJourneyState(event);
    } else if (event is LoadJourneys) {
      yield* _mapLoadJourneyState(event);
    }
  }

  Stream<JourneyState> _mapAddJourneyState(AddJourney event) async* {
    if (currentState is JourneyLoaded) {
      final List<Journey> updatedJourneys =
          // ignore: avoid_as
          List.from((currentState as JourneyLoaded).journeys)
            ..add(event.journey);
      yield JourneyLoaded(journeys: updatedJourneys);
      _saveJourneys([event.journey]);
    }
  }

  void _saveJourneys(List<Journey> journeys) {
    for (Journey j in journeys) {
      final mapped = j.toJson();
      journeysRepository.saveJourneys([mapped]);
    }
//    final journeyMap = journeys
//        .map<Map<String, dynamic>>(
//          (journey) => journey.toJson(),
//        )
//        .toList();
//    print(journeyMap);
//    journeysRepository.saveJourneys(journeyMap);
  }

  Future<List<Journey>> _loadJourneys() async {
    final List<Map<String, dynamic>> jsonJourneys =
        await journeysRepository.loadJourneys();
    return jsonJourneys
        .map((jsonJourney) => Journey.fromJson(jsonJourney))
        .toList();
  }

  Stream<JourneyState> _mapLoadJourneyState(LoadJourneys event) async* {
    if (currentState is JourneyUninitialised) {
      final List<Journey> journeys = await _loadJourneys();
      yield JourneyLoaded(journeys: journeys);
    }
  }
}
