import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:meta/meta.dart';

class ArtistEntity extends Equatable {
  ArtistEntity({
    @required this.artistID,
    @required this.name,
    @required this.email,
    @required this.studioID,
    this.artistImage,
  }) : super(<dynamic>[artistID, name, email, studioID]);

  factory ArtistEntity.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final int artistID = json['id'] ?? -1;
    final String name = json['name'] ?? '';
    final String email = json['email'] ?? '';
    final int studioID = json['studioID'] ?? -1;

    Widget image;
    if (json['profileUrl'] == null) {
      image = Image.asset(
        'assets/ricky.png',
        fit: BoxFit.cover,
      );
    } else {
      image = Stack(
        children: <Widget>[
          Center(
            child: SpinKitChasingDots(
              color: Colors.white,
              size: 50.0,
            ),
          ),
          Positioned.fill(
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/transparent.png',
              image: json['profileUrl'],
              fit: BoxFit.cover,
            ),
          ),
        ],
      );
    }

    return ArtistEntity(
      artistID: artistID,
      name: name,
      email: email,
      studioID: studioID,
      artistImage: image,
    );
  }

  final int artistID;
  final String name;
  final String email;
  final int studioID;
  final Widget artistImage;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'artist_id': artistID,
      'name': name,
      'email': email,
      'studioID': studioID,
    };
  }
}
