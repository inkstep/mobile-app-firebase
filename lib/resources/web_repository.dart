import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

class WebRepository {
  const WebRepository({
    @required this.client,
    this.delay = const Duration(milliseconds: 300),
  });

  final http.Client client;
  final Duration delay;

  static const String url = 'http://inkstep-backend.eu-west-2.elasticbeanstalk.com';
  //static const String url = 'http://localhost:4567';

  static const String userEndpoint = '/user';
  static const String journeyEndpoint = '/journey';
  static const String imageEndpoint = '/image';
  static const String imagesEndpoint = '/images';
  static const String artistEndpoint = '/artist';
  static const String studiosEndpoint = '/studio';
  static const String tattooEndpoint = '/tattoo';
  static const String emailEndpoint = '/email';

  Future<List<Map<String, dynamic>>> loadArtists(int studioID) async {
    final http.Response response = await client.get('$url$artistEndpoint');

    print(
        'GET $artistEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    final mappedArtists = <Map<String, dynamic>>[];
    final List<dynamic> jsonArtists = json.decode(response.body);
    for (dynamic j in jsonArtists) {
      final Map<String, dynamic> mappedArtist = j;
      mappedArtists.add(mappedArtist);
    }
    return mappedArtists;
  }

  Future<List<Map<String, dynamic>>> loadJourneys(int userID) async {
    final http.Response response = await client.get('$url$journeyEndpoint?user=$userID');

    print(
        'GET $journeyEndpoint?user=$userID ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

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

  Future<Map<String, dynamic>> loadJourney(int id) async {
    final http.Response response = await client.get('$url$journeyEndpoint/$id');

    print('GET $journeyEndpoint/$id '
        '${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }

    return json.decode(response.body);
  }

  Future<int> saveJourneys(List<Map<String, dynamic>> journeys) async {
    for (Map<String, dynamic> journeyMap in journeys) {
      final String jsonStr = jsonEncode(journeyMap);
      print('Saving Journey: $jsonStr');

      final http.Response response = await client.put('$url$journeyEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});

      print(
          'PUT $journeyEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseJson = jsonDecode(response.body);
        return Future.value(int.parse(responseJson['journey_id']));
      }
    }
    return Future.value(-1);
  }

  Future<bool> removeJourney(int journeyID) async {
    final http.Response response = await client.delete('$url$journeyEndpoint/$journeyID');
    print('GET $journeyEndpoint/$journeyID '
        '${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }
    return true;
  }

  Future<int> saveUser(Map<String, dynamic> userMap) async {
    final String jsonStr = jsonEncode(userMap);
    print('Saving User: $jsonStr');

    http.Response response;

    try {
      response = await http
          .put('$url$userEndpoint', body: jsonStr, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Future.value(-1);
    }
    print('$userEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      return Future.value(int.parse(responseJson['user_id']));
    }
    return Future.value(-1);
  }

  Future<int> saveImage(Map<String, dynamic> imageMap) async {
    final String jsonStr = jsonEncode(imageMap);
    print('Saving Image: $jsonStr');

    http.Response response;

    try {
      response = await client.put('$url$journeyEndpoint$imageEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Future.value(-1);
    }

    print(
        '$journeyEndpoint$imageEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      return Future.value(int.parse(responseJson['image_id']));
    }
    return Future.value(-1);
  }

  Future<Map<String, dynamic>> loadArtist(int artistId) async {
    final http.Response response = await client.get('$url$artistEndpoint/$artistId');

    print(
        '$artistEndpoint/$artistId ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }

    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> loadUser(int userId) async {
    final http.Response response = await client.get('$url$userEndpoint/$userId');

    print('GET $userEndpoint/$userId ${response.reasonPhrase} (${response.statusCode}):');
    print('${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }
    return json.decode(response.body);
  }

  Future<List<String>> loadImages(int id) async {
    print('journey_id = $id');

    final http.Response response = await client.get('$url$journeyEndpoint/$id$imagesEndpoint');

    print(
        '$journeyEndpoint/$id$imagesEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }

    final List<dynamic> responseData = json.decode(response.body);
    List<String> imageData = [];
    for (String data in responseData) {
      imageData += [data];
    }

    return imageData;
  }

  Future<Map<String, dynamic>> loadStudio(int studioID) async {
    final http.Response response = await client.get('$url$studiosEndpoint/$studioID');

    print('GET $studiosEndpoint/$studioID ${response.reasonPhrase} (${response.statusCode}):');
    print('${response.body}');

    if (response.statusCode != 200) {
      throw http.ClientException;
    }

    return json.decode(response.body);
  }

  Future<List<Map<String, dynamic>>> loadStudios() async {
    final http.Response response = await client.get('$url$studiosEndpoint');

    print(
        'GET $studiosEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response.body}');

    final mappedStudios = <Map<String, dynamic>>[];
    final List<dynamic> jsonStudios = json.decode(response.body);
    for (dynamic j in jsonStudios) {
      final Map<String, dynamic> mappedArtist = j;
      mappedStudios.add(mappedArtist);
    }
    return mappedStudios;
  }

  Future<int> updateJourneyRow(Map<String, dynamic> journeyMap, int journeyId) async {
    final String jsonStr = jsonEncode(journeyMap);

    final http.Response response = await client.patch('$url$journeyEndpoint/$journeyId',
        body: jsonStr, headers: {'Content-Type': 'application/json'});

    print('PATCH $journeyEndpoint/$journeyId ${response.reasonPhrase} '
        '(${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      return Future.value(int.parse(responseJson['journey_id']));
    }
    return Future.value(-1);
  }

  Future<bool> sendArtistPhoto(Map<String, dynamic> photoMap) async {
    final String jsonStr = jsonEncode(photoMap);
    print('Saving Image: $jsonStr');

    http.Response response;

    try {
      response = await client.put('$url$journeyEndpoint$imageEndpoint$tattooEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
      return false;
    }

    print(
        '$journeyEndpoint$imageEndpoint$tattooEndpoint ${response.reasonPhrase} (${response.statusCode}): ${response
            .body}');

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> saveUserEmail(Map<String, dynamic> emailMap, int id) async {
    final String jsonStr = jsonEncode(emailMap);

    http.Response response;

    try {
      response = await client.put('$url$userEndpoint/$id$emailEndpoint',
          body: jsonStr, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      print(e);
      return true;
    }

    print(
        '$userEndpoint/$id$emailEndpoint ${response.reasonPhrase} (${response.statusCode}): '
            '${response
            .body}');

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<int> updateUserRow(Map<String, String> userMap, int userId) async {
    final String jsonStr = jsonEncode(userMap);

    final http.Response response = await client.patch('$url$userEndpoint/$userId',
        body: jsonStr, headers: {'Content-Type': 'application/json'});

    print('PATCH $userEndpoint/$userId ${response.reasonPhrase} '
        '(${response.statusCode}): ${response.body}');
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseJson = jsonDecode(response.body);
      return Future.value(int.parse(responseJson['user_id']));
    }
    return Future.value(-1);
  }
}
