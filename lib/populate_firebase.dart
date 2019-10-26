import 'dart:ui';

import 'package:inkstep/resources/offline_data.dart';
import 'package:inkstep/utils/image_utils.dart';

void main() {
  final String authUid = "-1";

  // Upload the test journeys and their images
  for (int i = 0; i < offlineJourneys.length; i++) {
    offlineJourneys[i].upload(authUid);

    // Upload the images for this journey
    for (Image image in offlineJourneyImages[i]) {
      ImageUtils.uploadImage(image);
    }
  }
}
