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
  Future<List<JourneyEntity>> loadJourneys({@required int userId}) async {
    final List<Map<String, dynamic>> mapped = await webClient.loadJourneys(userId);
    return mapped.map((jsonJourney) => JourneyEntity.fromJson(jsonJourney)).toList();
  }

  // Persists journeys to the web
  Future<int> saveJourneys(List<JourneyEntity> journeys) async {
    final journeysMap = journeys.map<Map<String, dynamic>>((j) => j.toJson()).toList();
    return await webClient.saveJourneys(journeysMap);
  }

  Future<int> saveUser(UserEntity user) async {
    return await webClient.saveUser(user.toJson());
  }

  Future<int> saveImage(int journeyId, Asset img) async {
    final ByteData byteData = await img.requestThumbnail(800, 800);
    final List<int> data = byteData.buffer.asUint8List();

    final Map imageMap = <String, dynamic>{
      'journey_id': journeyId,
      'image_data': base64Encode(data),
    };
    return await webClient.saveImage(imageMap);
  }

  Future<Artist> loadArtist(int artistId) async {
    return Artist.fromJson(await webClient.loadArtist(artistId));
  }

  Future<User> getUser(int userId) async {
    return User.fromJson(await webClient.loadUser(userId));
  }
}
