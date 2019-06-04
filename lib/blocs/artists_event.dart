import 'package:equatable/equatable.dart';

abstract class ArtistsEvent extends Equatable {
  ArtistsEvent([List props = const <dynamic>[]]) : super(props);
}

class LoadArtistsEvent extends ArtistsEvent {
  LoadArtistsEvent(this.studioID) : super(<dynamic>[studioID]);

  final int studioID;
}
