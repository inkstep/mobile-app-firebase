import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({@required this.webClient});

  final WebClient webClient;

  // Loads journeys from a Web Client.
  Future<List<JourneyEntity>> loadJourneys({int userId}) async {
    final List<Map<String, dynamic>> mapped = await webClient.loadJourneys();
    return mapped.map((jsonJourney) => JourneyEntity.fromJson(jsonJourney)).toList();
  }

  // Persists journeys to the web
  Future<int> saveJourneys(List<JourneyEntity> journeys) async {
    final journeysMap = journeys.map<Map<String, dynamic>>((j) => j.toJson()).toList();
    return await webClient.saveJourneys(journeysMap);
  }

  Future<int> saveUser(UserEntity user) async {
    final userMap = user.toJson();
    return await webClient.saveUser(userMap);
  }

  Future<Artist> getArtist(int artistId) {
    return Future.value(Artist(name: 'Ricky', email: 'ricky@scm.com', studio: 'South City Market'));
  }

  Future<User> getUser(int userId) {
    return Future.value(User(id: userId, name: 'test.user', email: 'test.email'));
  }
}
