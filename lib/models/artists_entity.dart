import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ArtistEntity extends Equatable {
  ArtistEntity({
    @required this.artistID,
    @required this.name,
    @required this.email,
    @required this.studioID,
    this.profileUrl,
  }) : super(<dynamic>[artistID, name, email, studioID]);

  factory ArtistEntity.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final int artistID = json['id'] ?? -1;
    final String name = json['name'] ?? '';
    final String email = json['email'] ?? '';
    final int studioID = json['studioID'] ?? -1;
    final String profileUrl = json['imagePath'] ??
        'https://southcitymarket.com/wp-content/uploads/2019/05/ricky-540x540.jpg';
    return ArtistEntity(
      artistID: artistID,
      name: name,
      email: email,
      studioID: studioID,
      profileUrl: profileUrl,
    );
  }

  final int artistID;
  final String name;
  final String email;
  final int studioID;
  final String profileUrl;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'artist_id': artistID,
      'name': name,
      'email': email,
      'studioID': studioID,
    };
  }
}
