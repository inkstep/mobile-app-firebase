import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:inkstep/models/journey_model.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

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
  Future<int> saveJourneys(List<Journey> journeys) async {
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

  Future<int> saveImage(Asset asset, int journeyId) async {
    final ByteData assetData = await asset.requestOriginal();

    final List<int> data = assetData.buffer.asUint8List();

    final Map<String, dynamic> imageMap = <String, dynamic>{
      'journey_id' : journeyId,
      'image_data' : base64Encode(data),
    };
    return await webClient.saveImage(imageMap);
  }
}
