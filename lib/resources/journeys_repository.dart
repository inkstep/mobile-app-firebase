import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/empty_journey_entity.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

// TODO(DJRHails): provide local file storage as well
class JourneysRepository {
  const JourneysRepository({@required this.webClient});

  final WebRepository webClient;

  // Loads journeys from a Web Client.
  Future<List<JourneyEntity>> loadJourneys({@required int userId}) async {
    final List<Map<String, dynamic>> mapped = await webClient.loadJourneys(userId);
    return mapped.map((jsonJourney) => JourneyEntity.fromJson(jsonJourney)).toList();
  }

  Future<JourneyEntity> loadJourney({@required int id}) async {
    final Map<String, dynamic> jsonJourney = await webClient.loadJourney(id);
    return JourneyEntity.fromJson(jsonJourney);
  }

  // Persists journeys to the web
  Future<int> saveJourneys(List<EmptyJourneyEntity> journeys) async {
    final journeysMap = journeys.map<Map<String, dynamic>>((j) => j.toJson()).toList();
    return await webClient.saveJourneys(journeysMap);
  }

  void removeJourney(int journeyId) {
    webClient.removeJourney(journeyId);
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

    int sendLimit = 10;
    int imageId = -1;
    while ((imageId = await webClient.saveImage(imageMap)) == -1 && sendLimit > 0) {
      sendLimit--;
    }

    return imageId;
  }

  Future<ArtistEntity> loadArtist(int artistId) async {
    return ArtistEntity.fromJson(await webClient.loadArtist(artistId));
  }

  Future<User> getUser(int userId) async {
    return User.fromJson(await webClient.loadUser(userId));
  }

  Future<List<Image>> getImages(int id) async {
    final List<String> imageData = await webClient.loadImages(id);

    List<Image> images = [];

    for (String data in imageData) {
      final List<int> byteData = base64Decode(data);
      images += [Image.memory(byteData)];
    }

    return Future.value(images);
  }

  Future<int> updateStage(JourneyStage updateStage, int journeyId) async {
    final Map<String, int> journeyMap = {'Stage': updateStage.numberRepresentation};
    return await webClient.updateRow(journeyMap, journeyId);
  }

  Future<bool> sendArtistPhoto(File imageData, int journeyId) async {
    final List<int> bytes = imageData.readAsBytesSync();
    final String encodedImage = base64Encode(bytes);

    final Map<String, dynamic> photoMap = <String, dynamic>{
      'image_data': encodedImage,
      'journey_id': journeyId,
    };

    int sendLimit = 10;
    while (!await webClient.sendArtistPhoto(photoMap) && sendLimit > 0) {
      sendLimit--;
    }

    return true;
  }

  void saveUserEmail(int id, String email) async {
    final Map<String, dynamic> emailMap = <String, dynamic>{
      'Email': email,
    };

    await webClient.saveUserEmail(emailMap, id);
  }
}
