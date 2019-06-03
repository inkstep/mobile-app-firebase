import 'dart:convert';

import 'package:http/http.dart' as http;

class WebClient {
  const WebClient([this.delay = const Duration(milliseconds: 300)]);

  final Duration delay;

  Future<List<Map<String, dynamic>>> fetchJourneys() async {
    return Future.delayed(
      delay,
      () => [],
    );
  }

  Future<bool> postJourneys(List<Map<String, dynamic>> journeys) async {
    for (Map<String, dynamic> journeyMap in journeys) {
      final String jsonStr = jsonEncode(journeyMap);
      print(jsonStr);
      print('About to send');

      final http.Response response = await http.put(
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
