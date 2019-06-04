import 'package:equatable/equatable.dart';
import 'package:inkstep/models/artists_model.dart';
import 'package:meta/meta.dart';

abstract class ArtistsState extends Equatable {
  ArtistsState([List<dynamic> props = const <dynamic>[]]) : super(props);
}

class ArtistsUninitialised extends ArtistsState {
  @override
  String toString() => 'ArtistsUninitialised';
}

class ArtistsError extends ArtistsState {
  @override
  String toString() => 'ArtistsError';
}

class ArtistsLoaded extends ArtistsState {
  ArtistsLoaded({@required this.artists}) : super(<dynamic>[artists]);

  final List<Artist> artists;

  @override
  String toString() => 'ArtistsLoaded { artists: ${artists?.length}';
}
