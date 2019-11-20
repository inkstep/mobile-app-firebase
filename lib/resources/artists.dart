import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/artist.dart';
import 'package:inkstep/models/studio.dart';

// Studios
final Studio _offlineScmEntity = Studio(id: 0, name: 'South City Market');
final List<Studio> offlineStudios = [_offlineScmEntity];

// Artists
final List<Artist> offlineArtists = [
  Artist(
    email: 'ricky@email.com',
    name: 'Ricky',
    studioID: _offlineScmEntity.id,
    artistId: 0,
    profileImage: Image.asset(
      'assets/offline/ricky.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Artist(
    email: 'loz@email.com',
    name: 'Loz',
    studioID: _offlineScmEntity.id,
    artistId: 1,
    profileImage: Image.asset(
      'assets/offline/loz.jpg',
      fit: BoxFit.cover,
    ),
  )
];
