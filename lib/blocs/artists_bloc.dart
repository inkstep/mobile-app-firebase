import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inkstep/models/artists_entity.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:inkstep/models/studio_entity.dart';
import 'package:inkstep/models/studio_model.dart';
import 'package:inkstep/resources/artists_repository.dart';
import 'package:meta/meta.dart';


// EVENT

abstract class ArtistsEvent extends Equatable {
  ArtistsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadArtists extends ArtistsEvent {
  LoadArtists(this.studioID) : super(<dynamic>[studioID]);

  final int studioID;
}


// STATE

abstract class ArtistsState extends Equatable {
  ArtistsState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class ArtistsUninitialised extends ArtistsState {
  @override
  String toString() => 'ArtistsUninitialised';
}

class ArtistsLoaded extends ArtistsState {
  ArtistsLoaded({@required this.artists}) : super(<dynamic>[artists]);

  final List<Artist> artists;

  @override
  String toString() => 'ArtistsLoaded { artists: ${artists?.length}';
}


// BLOC

class ArtistsBloc extends Bloc<ArtistsEvent, ArtistsState> {
  ArtistsBloc({@required this.artistsRepository});

  final ArtistsRepository artistsRepository;

  @override
  ArtistsState get initialState => ArtistsUninitialised();

  @override
  Stream<ArtistsState> mapEventToState(ArtistsEvent event) async* {
    if (event is LoadArtists && currentState is ArtistsUninitialised) {
      final List<ArtistEntity> artistEntities = await artistsRepository.loadArtists(event.studioID);
      final List<StudioEntity> studioEntities = await artistsRepository.loadStudios();

      List<Artist> artists = [];
      for (ArtistEntity artistEntity in artistEntities) {
        StudioEntity se;
        for (StudioEntity studioEntity in studioEntities) {
          if (studioEntity.id == artistEntity.studioID) {
            se = studioEntity;
            break;
          }
        }
        artists += [
          Artist(
            name: artistEntity.name,
            email: artistEntity.email,
            profileImage: artistEntity.artistImage,
            studio: Studio(name: se.name, id: 1),
            artistID: artistEntity.artistID,
          )
        ];
      }

      yield ArtistsLoaded(artists: artists);
    }
  }
}
