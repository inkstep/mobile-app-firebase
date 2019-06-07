import 'dart:async';
import 'dart:core';

import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/resources/web_repository.dart';
import 'package:meta/meta.dart';

// TODO(DJRHails): provide local file storage as well
class ArtistsRepository {
  const ArtistsRepository({@required this.webClient});

  final WebRepository webClient;

  // Loads artists from a Web Client.
  Future<List<ArtistEntity>> loadArtists(int studioID) async {
    final List<Map<String, dynamic>> mapped = await webClient.loadArtists(studioID);
    return mapped.map((jsonArtist) => ArtistEntity.fromJson(jsonArtist)).toList();
  }

  Future<StudioEntity> loadStudio(int studioID) async {
    final Map<String, dynamic> jsonStudio = await webClient.loadStudio(studioID);
    return StudioEntity.fromJson(jsonStudio);
  }

  Future<List<StudioEntity>> loadStudios() async {
    final List<Map<String, dynamic>> mapped = await webClient.loadStudios();
    return mapped.map((jsonStudio) => StudioEntity.fromJson(jsonStudio)).toList();
  }
}
