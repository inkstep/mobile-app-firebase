import 'package:inkstep/resources/offline_data.dart';

import 'models/journey.dart';

void main() {
  // Upload the test journeys
  final String authUid = "-1";
  for (Journey journey in offlineJourneys) {
    journey.upload(authUid);
  }

  // Add images

}
