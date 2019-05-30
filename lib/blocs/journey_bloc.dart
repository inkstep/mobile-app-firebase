import 'package:bloc/bloc.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/journey_provider.dart';

enum JourneyEvent { add }

class JourneyBloc extends Bloc<JourneyEvent, List<Journey>> {
  final JourneysProvider _provider = JourneysProvider();

  @override
  List<Journey> get initialState => [];

  @override
  Stream<List<Journey>> mapEventToState(JourneyEvent event) async* {
    print('Adding new journey');
    yield await _provider.getClientJourneys();
  }
}
