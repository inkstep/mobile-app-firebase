import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:inkstep/resources/artists.dart';
import 'package:meta/meta.dart';

class Artist extends Equatable {
  Artist({
    @required this.artistID,
    @required this.name,
    @required this.email,
    @required this.studioID,
    @required this.profileImage,
  }) : super(<dynamic>[artistID]);

  factory Artist.fromId(int id) {
    return offlineArtists.firstWhere((artist) => artist.artistID == id);
  }

  final int artistID;
  final String name;
  final String email;
  final int studioID;
  Widget profileImage;
}
