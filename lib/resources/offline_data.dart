import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/models/studio_model.dart';
import 'package:inkstep/models/user_model.dart';

final User offlineUser = User(id: 0, name: 'Natasha', email: 'natasha@email.com');
final List<User> offlineUsers = [offlineUser];

final Studio offlineScm = Studio(id: 0, name: 'South City Market');
final StudioEntity offlineScmEntity = StudioEntity(id: 0, name: 'South City Market');

final List<StudioEntity> offlineStudios = [offlineScmEntity];

final List<ArtistEntity> offlineArtists = [
  ArtistEntity(
    email: 'ricky@email.com',
    name: 'Ricky',
    studioID: 0,
    artistID: 2,
    artistImage: Image.asset(
      'assets/offlineImages/ricky.jpg',
      fit: BoxFit.cover,
    ),
  ),
  ArtistEntity(
    email: 'loz@email.com',
    name: 'Loz',
    studioID: 0,
    artistID: 1,
    artistImage: Image.asset(
      'assets/offlineImages/loz.jpg',
      fit: BoxFit.cover,
    ),
  )
];

final JourneyEntity offlineCherub = JourneyEntity(
  id: 0,
  userId: 0,
  artistId: 1,
  mentalImage: 'Cherub',
  size: '8cm by 6cm',
  position: 'Bicep',
  availability: '0000011',
  noImages: 2,
  stage: WaitingForQuote(),
);

final JourneyEntity offlineRose = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: WaitingForQuote(),
);

final Image offlineRoseImage1 = Image.asset('assets/offlineImages/rose1.png');
final Image offlineRoseImage2 = Image.asset('assets/offlineImages/rose2.png');

final Image offlineCherubImage1 = Image.asset('assets/offlineImages/cherub1.png');
final Image offlineCherubImage2 = Image.asset('assets/offlineImages/cherub2.png');

final Map<int, List<Image>> offlineJourneyImages = {
  0: [offlineCherubImage1, offlineCherubImage2],
  1: [offlineRoseImage1, offlineRoseImage2],
};
