import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/journey_entity.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/models/studio_model.dart';
import 'package:inkstep/models/user_model.dart';

// Users
final UserModel offlineUser = UserModel(id: 0, name: 'Natasha', email: 'natasha@email.com');
final List<UserModel> offlineUsers = [offlineUser];

// Studios
final Studio offlineScm = Studio(id: 0, name: 'South City Market');
final StudioEntity offlineScmEntity = StudioEntity(id: 0, name: 'South City Market');
final List<StudioEntity> offlineStudios = [offlineScmEntity];

// Artists
final List<ArtistEntity> offlineArtists = [
  ArtistEntity(
    email: 'ricky@email.com',
    name: 'Ricky',
    studioID: 0,
    artistID: 2,
    artistImage: Image.asset(
      'assets/offline/ricky.jpg',
      fit: BoxFit.cover,
    ),
  ),
  ArtistEntity(
    email: 'loz@email.com',
    name: 'Loz',
    studioID: 0,
    artistID: 1,
    artistImage: Image.asset(
      'assets/offline/loz.jpg',
      fit: BoxFit.cover,
    ),
  )
];

// Journeys
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
final JourneyEntity offlineRose1 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 1',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: WaitingForQuote(),
);
final JourneyEntity offlineRose2 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 2',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: QuoteReceived(TextRange(start: 120, end: 140)),
);
final JourneyEntity offlineRose3 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 3',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: WaitingForAppointmentOffer(TextRange(start: 120, end: 140)),
);
final JourneyEntity offlineRose4 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 4',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: AppointmentOfferReceived(DateTime(2019, 11, 14, 14), TextRange(start: 120, end: 140)),
);
final JourneyEntity offlineRose5 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 5',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: BookedIn(DateTime(2019, 10, 1, 15), TextRange(start: 120, end: 140)),
);
final JourneyEntity offlineRose6 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 6',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: WaitingList(TextRange(start: 100, end: 120)),
);
final JourneyEntity offlineRose7 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 7',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: Aftercare(DateTime(2019, 7, 20, 15)),
);
final JourneyEntity offlineRose8 = JourneyEntity(
  id: 1,
  userId: 0,
  artistId: 2,
  mentalImage: 'Rose 8',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  noImages: 2,
  stage: Healed(),
);
final List<JourneyEntity> offlineJourneys = [
  offlineCherub,
  offlineRose1,
  offlineRose2,
  offlineRose3,
  offlineRose4,
  offlineRose5,
  offlineRose6,
  offlineRose7,
  offlineRose8,
];

// Journey Images
final Map<int, List<Image>> offlineJourneyImages = {
  0: [Image.asset('assets/offline/cherub1.png'), Image.asset('assets/offline/cherub2.png')],
  1: [Image.asset('assets/offline/rose1.png'), Image.asset('assets/offline/rose2.png')],
  2: [Image.asset('assets/offline/rose1.png'), Image.asset('assets/offline/rose2.png')],
  3: [Image.asset('assets/offline/rose1.png'), Image.asset('assets/offline/rose2.png')],
  4: [Image.asset('assets/offline/rose1.png'), Image.asset('assets/offline/rose2.png')],
  5: [Image.asset('assets/offline/rose1.png'), Image.asset('assets/offline/rose2.png')],
};
