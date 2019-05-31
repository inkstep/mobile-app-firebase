import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Journey extends Equatable {
  Journey({
    @required this.artistName,
    this.studioName = '',
    this.artistEmail = 'james.dalboth@gmail.com',
    this.type = '',
    @required this.name,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.deposit,
  }) : super(<dynamic>[
          artistName,
          studioName,
          artistEmail,
          type,
          name,
          mentalImage,
          size,
          position,
          email,
          availability,
          deposit
        ]);

  Journey.fromJson(Map<String, dynamic> json)
      : artistName = json['artist_name'],
        studioName = '',
        artistEmail = json['artist_email'],
        name = json['user_name'],
        type = json['tattoo'],
        mentalImage = json['desc'],
        size = json['size'],
        position = json['pos'],
        email = '',
        availability = '',
        deposit = '';

  final String artistName;
  final String studioName;
  final String artistEmail;
  final String name;
  final String mentalImage;
  final String size;
  final String position;
  final String email;
  final String availability;
  final String deposit;
  final String type;

  Map<String, dynamic> toJson() {
    final x = <String, dynamic>{
      'artist_name': artistName,
      'artist_email': artistEmail,
      'user_name': name,
      'tattoo': type,
      'desc': mentalImage,
      'size': size,
      'pos': position,
    };
    return x;
  }
}
