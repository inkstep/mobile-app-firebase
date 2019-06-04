import 'dart:convert';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;
  String get url => 'http://inkstep-backend.eu-west-2.elasticbeanstalk.com';
  String get journeyEndpoint => '/journey';

  Future<List<Map<String, dynamic>>> loadArtists() async {
    return [];
  }

  Future<List<Map<String, dynamic>>> loadJourneys() async {
    final http.Response response = await http.get('$url$journeyEndpoint');

    print('Response(${response.statusCode}): ${response.reasonPhrase}');

    final mappedJourneys = <Map<String, dynamic>>[];
    final List<dynamic> jsonJourneys = json.decode(response.body);
    for (dynamic j in jsonJourneys) {
      final Map<String, dynamic> mappedJourney = j;
      mappedJourneys.add(mappedJourney);
    }
    return mappedJourneys;
  }

  Future<bool> saveJourneys(List<Map<String, dynamic>> journeys) async {
    for (Map<String, dynamic> journeyMap in journeys) {
      final String jsonStr = jsonEncode(journeyMap);
      print('Saving Journey: $jsonStr');

      final http.Response response = await http.put('$url$journeyEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});

      print(response.body);

      print('Response(${response.statusCode}): ${response.reasonPhrase}');

      if (response.statusCode != 200) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }

  Future<int> saveUser(Map<String, dynamic> userMap) {

  }
}
