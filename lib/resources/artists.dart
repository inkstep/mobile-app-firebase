import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:inkstep/models/artist.dart';

// Artists
final List<Artist> offlineArtists = [
  Artist(
    email: 'ricky@email.com',
    name: 'Ricky Williams',
    artistId: 0,
    profileImage: Image.asset(
      'assets/offline/ricky.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Artist(
    email: 'loz@email.com',
    name: 'Loz McLean',
    artistId: 1,
    profileImage: Image.asset(
      'assets/offline/loz.jpg',
      fit: BoxFit.cover,
    ),
  ),
  Artist(
    email: 'peter@email.com',
    name: 'Peter Laeviv',
    artistId: 2,
    profileImage: Image.asset(
      'assets/offline/peter.jpg',
      fit: BoxFit.cover,
    ),
  )
];
