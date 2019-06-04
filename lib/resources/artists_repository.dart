import 'dart:async';
import 'dart:core';

import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/resources/web_client.dart';
import 'package:meta/meta.dart';

// TODO(DJRHails): provide local file storage as well
class ArtistsRepository {
  const ArtistsRepository({@required this.webClient});

  final WebClient webClient;

  // Loads artists from a Web Client.
  Future<List<Artist>> loadArtists(int studioID) async {
    final List<Map<String, dynamic>> mapped = await webClient.loadArtists(studioID);
    return mapped.map((jsonArtist) => Artist.fromJson(jsonArtist)).toList();
  }
}
