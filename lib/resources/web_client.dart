import 'dart:convert';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;

  static const String url = 'http://inkstep-backend.eu-west-2.elasticbeanstalk.com';

  static const String userEndpoint = '/user';
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

    if (response.statusCode != 200) {
      throw http.ClientException;
    }

    final mappedJourneys = <Map<String, dynamic>>[];
    final List<dynamic> jsonJourneys = json.decode(response.body);
    for (dynamic j in jsonJourneys) {
      final Map<String, dynamic> mappedJourney = j;
      mappedJourneys.add(mappedJourney);
    }
    return mappedJourneys;
  }

  Future<int> saveJourneys(List<Map<String, dynamic>> journeys) async {
    for (Map<String, dynamic> journeyMap in journeys) {
      final String jsonStr = jsonEncode(journeyMap);
      print('Saving Journey: $jsonStr');

      final http.Response response = await http.put('$url$journeyEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});

      print(response.body);

      print('Response(${response.statusCode}): ${response.reasonPhrase}');

      if (response.statusCode != 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        return Future.value(int.parse(responseJson['journey_id']));
      }
    }
    return Future.value(-1);
  }

  Future<int> saveUser(Map<String, dynamic> userMap) async {
    final String jsonStr = jsonEncode(userMap);
    print('Saving User: $jsonStr');

    http.Response response;

    try {
      response = await http.put(
          '$url$userEndpoint',
          body: jsonStr,
          headers: {'Content-Type': 'application/json'}
          );
    } catch (e) {
      return Future.value(-1);
    }

    print('Response(${response.statusCode}): ${response.reasonPhrase}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      return Future.value(int.parse(responseJson['user_id']));
    }
    return Future.value(-1);
  }
}
