import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ArtistEntity extends Equatable {
  ArtistEntity(
      {@required this.artistID, @required this.name, @required this.email, @required this.studioID})
      : super(<dynamic>[artistID, name, email, studioID]);

  factory ArtistEntity.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final int artistID = json['artistID'] ?? '';
    final String name = json['name'] ?? '';
    final String email = json['email'] ?? '';
    final int studioID = json['studioID'] ?? '';

    return ArtistEntity(artistID: artistID, name: name, email: email, studioID: studioID);
  }

  final int artistID;
  final String name;
  final String email;
  final int studioID;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'artist_id': artistID,
      'name': name,
      'email': email,
      'studioID': studioID
    };
  }
}
