import 'package:inkstep/models/journey_model.dart';

class JourneysProvider {
  Future<List<Journey>> getClientJourneys() async {
    return [Journey('Ricky', 'South City Market')];
  }
}
