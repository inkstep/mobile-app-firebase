import 'package:inkstep/resources/offline_data.dart';

void main() {
  const String authUid = '-1';

  // Upload the test journeys and their images
  for (int i = 0; i < offlineJourneys.length; i++) {
    offlineJourneys[i].upload(authUid);
    for (int j = 0; j < offlineJourneyImages[i].length; j++) {
      // TODO(mm): use correct image classes to get image data and upload
      // ImageUtils.uploadImage(offlineJourneyImages[i][j]);
    }
  }
}
