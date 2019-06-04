import 'package:bloc/bloc.dart';
import 'package:inkstep/blocs/artists_state.dart';
import 'package:inkstep/models/artists_model.dart';
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
    if (event is LoadArtistsEvent) {
      final List<Artist> artists = await artistsRepository.loadArtists(event.studioID);
      yield ArtistsLoaded(artists: artists);
    }
  }
}
