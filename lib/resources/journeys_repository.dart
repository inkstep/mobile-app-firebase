import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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

  Future<int> saveImage(int journeyId, Asset img) async {
    final ByteData byteData = await img.requestThumbnail(100, 100)
    final List<int> data = byteData.buffer.asUint8List();

    final Map imageMap = <String, dynamic>{
      'journey_id' : journeyId,
      'image_data' : base64Encode(data),
    };
    return await webClient.saveImage(imageMap);
  }

  Future<Artist> getArtist(int artistId) async {
    final Map<String, dynamic> mapped = await webClient.loadArtist(artistId);
    return Artist.fromJson(mapped);
  }

  Future<User> getUser(int userId) {
    return Future.value(User(id: userId, name: 'test.user', email: 'test.email'));
  }
}
