import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:inkstep/resources/offline_data.dart';
import 'package:inkstep/resources/web_repository.dart';

class OfflineArtistsRepository implements ArtistsRepository {
  @override
  Future<List<ArtistEntity>> loadArtists(int studioID) {
    return Future.value(offlineArtists);
  }

  @override
  Future<StudioEntity> loadStudio(int studioID) {
    return Future.value(offlineStudios.firstWhere((s) => s.id == studioID));
  }

  @override
  Future<List<StudioEntity>> loadStudios() {
    return Future.value(offlineStudios);
  }

  @override
  WebRepository get webClient => null;
}
