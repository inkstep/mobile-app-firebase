import 'package:inkstep/models/journey_model.dart';

class JourneysProvider {
  Future<List<JourneyModel>> getClientJourneys() async {
    return [JourneyModel("Ricky", "South City Market")];
  }
}
