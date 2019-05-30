import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({
    this.webClient,
  });

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

class WebClient {
  const WebClient([
    this.delay = const Duration(milliseconds: 300),
  ]);

  final String url = 'inkstep-backend.eu-west-2.elasticbeanstalk.com';

  final Duration delay;

  Future<List<Map<String, dynamic>>> fetchJourneys() async {
    return Future.delayed(
      delay,
      () => [
            <String, dynamic>{
              'artist': 'Ricky',
              'studio': 'South City Market',
            },
          ],
    );
  }

  Future<bool> postJourneys(List<Map<String, dynamic>> journeys) async {
    for (Map<String, dynamic> journeyMap in journeys) {
      String jsonStr = jsonEncode(journeyMap);
      print(jsonStr);

      var response = await http.put(
          'http://inkstep-backend.eu-west-2.elasticbeanstalk.com/journey',
          body: jsonStr,
          headers: {'Content-Type': 'application/json'});
      print('Status Code: ${response.statusCode}');
      if (response.statusCode != 200) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}
