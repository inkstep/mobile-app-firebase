import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/firestore.dart';
import 'package:inkstep/models/journey_stage.dart';
import 'package:inkstep/models/user_model.dart';

// Users
final UserModel offlineUser = UserModel(
  id: 0,
  name: 'Natasha',
  email: 'natasha@email.com',
  token: '',
);
final List<UserModel> offlineUsers = [offlineUser];

// Journeys
final TextRange _quote = TextRange(start: 100, end: 120);
final DateTime _date = DateTime(2019, 11, 14, 14);
final Journey offlineCherub = Journey(
  id: 0,
  userId: 0,
  artistId: 1,
  description: 'Cherub',
  size: '8cm by 6cm',
  position: 'Bicep',
  availability: '0000011',
  stage: WaitingForQuote(),
);
final Journey offlineRose1 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 1',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: WaitingForQuote(),
);
final Journey offlineRose2 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 2',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: QuoteReceived(_quote),
);
final Journey offlineRose3 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 3',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: WaitingForAppointmentOffer(_quote),
);
final Journey offlineRose4 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 4',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: AppointmentOfferReceived(_quote, _date),
);
final Journey offlineRose5 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 5',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: BookedIn(_quote, _date),
);
final Journey offlineRose6 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 6',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: WaitingList(_quote),
);
final Journey offlineRose7 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 7',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: Aftercare(_quote, _date),
);
final Journey offlineRose8 = Journey(
  id: 1,
  userId: 0,
  artistId: 2,
  description: 'Rose 8',
  size: '6cm by 3cm',
  position: 'Sternum',
  availability: '0101001',
  stage: Healed(_quote, _date),
);
final List<Journey> offlineJourneys = [
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
