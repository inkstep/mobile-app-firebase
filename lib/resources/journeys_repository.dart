import 'dart:async';
import 'dart:core';

import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({@required this.webClient});

  final WebClient webClient;

  /// Loads journeys from a Web Client.
  Future<List<Map<String, dynamic>>> loadJourneys() async {
    return await webClient.fetchJourneys();
  }

  // Persists journeys to the web
  Future saveJourneys(List<Map<String, dynamic>> journeys) {
    return Future.wait<dynamic>([
      webClient.postJourneys(journeys),
    ]);
  }
}
