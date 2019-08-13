import 'dart:async';
import 'dart:core';
import 'dart:io';

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

import 'offline_data.dart';

class OfflineJourneysRepository {
  @override
  Future<List<JourneyEntity>> loadJourneys({@required int userId}) async
    => Future.value(offlineJourneys);

  @override
  Future<int> saveJourneys(List<EmptyJourneyEntity> journeys) async
    => Future.value(0);

  @override
  Future<int> saveUser(UserEntity user) async
    => Future.value(0);

  @override
  Future<int> saveImage(int journeyId, Asset img) async
    => Future.value(0);

  @override
  Future<ArtistEntity> loadArtist(int artistId) async
    => Future.value(
        offlineArtists.firstWhere((a) => a.artistID == artistId, orElse: () => offlineArtists[0]));

  @override
  Future<UserModel> getUser(int userId) async
    => Future.value(
        offlineUsers.firstWhere((u) => u.id == userId, orElse: () => offlineUsers[0]));

  @override
  Future<List<Image>> getImages(int journeyId) async
    => Future.value(offlineJourneyImages[journeyId]);

  @override
  Future<List<Image>> getImageThumbnails(int journeyId, int numImages)
    => Future.value(offlineJourneyImages[journeyId]);

  @override
  Future<JourneyEntity> loadJourney({int id}) => null;

  @override
  void removeJourney(int journeyId) {}

  @override
  Future<bool> saveUserEmail(int id, String email) => null;

  @override
  Future<bool> sendArtistPhoto(File imageData, int journeyId) => null;

  @override
  Future<int> updateStage(JourneyStage updateStage, int journeyId) => null;

  @override
  Future<int> updateToken(String token, int userId) => null;

  @override
  WebRepository get webClient => null;
}
