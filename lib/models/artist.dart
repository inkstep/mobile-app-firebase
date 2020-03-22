import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:meta/meta.dart';

class Artist extends Equatable {
  Artist({
    @required this.artistId,
    @required this.name,
    @required this.email,
    @required this.profileImage,
  }) : super(<dynamic>[artistId]);

  factory Artist.fromId(int id) {
    return offlineArtists.firstWhere((artist) => artist.artistId == id);
  }

  final int artistId;
  final String name;
  final String email;
  Widget profileImage;
}
