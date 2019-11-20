import 'package:inkstep/resources/offline_data.dart';
import 'package:inkstep/utils/image_utils.dart';

void main() {
  const String authUid = '-1';

  // Upload the test journeys and their images
  for (int i = 0; i < offlineJourneys.length; i++) {
    offlineJourneys[i].upload(authUid);
    for (int j = 0; j < offlineJourneyImages[i].length; j++) {
      ImageUtils.uploadImage(offlineJourneyImages[i][j]);
    }
  }
}
