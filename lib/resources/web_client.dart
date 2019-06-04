import 'dart:convert';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;

  static const String url = 'http://inkstep-backend.eu-west-2.elasticbeanstalk.com';

  static const String journeyEndpoint = '/journey';
  static const String artistsEndpoint = '/artists';

  Future<List<Map<String, dynamic>>> loadArtists(int studioID) async {
    final http.Response response = await http.get('$url$artistsEndpoint');

    print('Response(${response.statusCode}): ${response.reasonPhrase}');

    final mappedArtists = <Map<String, dynamic>>[];
    final List<dynamic> jsonArtists = json.decode(response.body);
    for (dynamic j in jsonArtists) {
      final Map<String, dynamic> mappedArtist = j;
      mappedArtists.add(mappedArtist);
    }
    return mappedArtists;
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
      print('Response(${response.statusCode}): ${response.reasonPhrase}');
      if (response.statusCode != 200) {
        return Future.value(false);
      }
    }
    return Future.value(true);
  }
}
