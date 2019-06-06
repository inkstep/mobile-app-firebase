import 'package:bloc/bloc.dart';
import 'package:inkstep/blocs/artists_state.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/models/studio_model.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:meta/meta.dart';

import 'artists_event.dart';

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  ArtistsBloc({@required this.artistsRepository});

  final ArtistsRepository artistsRepository;

  @override
  ArtistsState get initialState => ArtistsUninitialised();

  @override
  Stream<ArtistsState> mapEventToState(ArtistsEvent event) async* {
    if (event is LoadArtists && currentState is ArtistsUninitialised) {
      final List<ArtistEntity> artistEntities = await artistsRepository.loadArtists(event.studioID);

      List<Artist> artists = [];
      for (ArtistEntity artistEntity in artistEntities) {
        final StudioEntity studioEntity = await artistsRepository.loadStudio(artistEntity.studioID);
        artists += [Artist(
          name: artistEntity.name,
          email: artistEntity.email,
          studio: Studio(
            name: studioEntity.name,
          ),
        )];
      }

      yield ArtistsLoaded(artists: artists);
    }
  }
}
