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
import 'package:inkstep/resources/journeys_repository.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import 'offline_data.dart';

class OfflineJourneysRepository implements JourneysRepository {
  @override
  Future<List<JourneyEntity>> loadJourneys({@required int userId}) async {
    return Future.value(
      <JourneyEntity>[offlineCherub, offlineRose],
    );
  }

  @override
  Future<int> saveJourneys(List<EmptyJourneyEntity> journeys) async {
    return Future.value(0);
  }

  @override
  Future<int> saveUser(UserEntity user) async {
    return Future.value(0);
  }

  @override
  Future<int> saveImage(int journeyId, Asset img) async {
    return Future.value(0);
  }

  @override
  Future<ArtistEntity> loadArtist(int artistId) async {
    return Future.value(
        offlineArtists.firstWhere((a) => a.artistID == artistId, orElse: () => offlineArtists[0]));
  }

  @override
  Future<User> getUser(int userId) async {
    return Future.value(
        offlineUsers.firstWhere((u) => u.id == userId, orElse: () => offlineUsers[0]));
  }

  @override
  Future<List<Image>> getImages(int journeyId) async {
    return Future.value(offlineJourneyImages[journeyId]);
  }

  @override
  Future<List<Image>> getImageThumbnails(int journeyId, int numImages) {
    return Future.value(offlineJourneyImages[journeyId]);
  }

  @override
  Future<JourneyEntity> loadJourney({int id}) {
    // TODO: implement loadJourney
    return null;
  }

  @override
  void removeJourney(int journeyId) {
    // TODO: implement removeJourney
  }

  @override
  Future<bool> saveUserEmail(int id, String email) {
    // TODO: implement saveUserEmail
    return null;
  }

  @override
  Future<bool> sendArtistPhoto(File imageData, int journeyId) {
    // TODO: implement sendArtistPhoto
    return null;
  }

  @override
  Future<int> updateStage(JourneyStage updateStage, int journeyId) {
    // TODO: implement updateStage
    return null;
  }

  @override
  Future<int> updateToken(String token, int userId) {
    // TODO: implement updateToken
    return null;
  }

  @override
  WebRepository get webClient => null;
}
