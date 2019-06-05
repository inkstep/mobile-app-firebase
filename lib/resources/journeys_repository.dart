import 'dart:async';
import 'dart:core';

import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({@required this.webClient});

  final WebClient webClient;

  // Loads journeys from a Web Client.
  Future<List<Journey>> loadJourneys() async {
    final List<Map<String, dynamic>> mapped = await webClient.loadJourneys();
    return mapped.map((jsonJourney) => Journey.fromJson(jsonJourney)).toList();
  }

  // Persists journeys to the web
  Future<bool> saveJourneys(List<Journey> journeys) async {
    final journeysMap = journeys.map<Map<String, dynamic>>((j) => j.toJson()).toList();
    return await webClient.saveJourneys(journeysMap);
  }

  Future<int> saveUser(String userName, String userEmail) async {
    final Map<String, dynamic> userMap = <String, dynamic>{
      'user_name' : userName,
      'user_email' : userEmail,
    };
    return await webClient.saveUser(userMap);
  }
}
