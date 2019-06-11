import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_status.dart';
import 'package:inkstep/models/user_entity.dart';
import 'package:inkstep/models/user_model.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class FakeJourneysRepository {
  final JourneyEntity j1 = JourneyEntity(
    id: 1,
    userId: 0,
    artistId: 0,
    mentalImage: 'Star',
    size: '',
    position: '',
    availability: '',
    deposit: '',
    noImages: 0,
    status: WaitingForResponse(),
  );

  final JourneyEntity j2 = JourneyEntity(
      id: 1,
      userId: 0,
      artistId: 0,
      mentalImage: 'Flower',
      size: '',
      position: '',
      availability: '',
      deposit: '',
      noImages: 0,
      status: WaitingForResponse());

  final User u1 = User(id: 0, name: 'test.name', email: 'test.email');
  final ArtistEntity a1 = ArtistEntity(
    email: 'artist@email.com',
    name: 'DoC Artist',
    studioID: 0,
    artistID: 0,
  );

  // Loads journeys from a Web Client.
  Future<List<JourneyEntity>> loadJourneys({@required int userId}) async {
    return Future.value(
      <JourneyEntity>[j1, j2],
    );
  }

  // Persists journeys to the web
  Future<int> saveJourneys(List<JourneyEntity> journeys) async {
    return Future.value(-1);
  }

  Future<int> saveUser(UserEntity user) async {
    return Future.value(-1);
  }

  Future<int> saveImage(int journeyId, Asset img) async {
    return Future.value(-1);
  }

  Future<ArtistEntity> loadArtist(int artistId) async {
    return Future.value(
      a1,
    );
  }

  Future<User> getUser(int userId) async {
    return Future.value(
      u1,
    );
  }

  Future<List<Image>> getImages(int id) async {
    return Future.value(<Image>[]);
  }
}
