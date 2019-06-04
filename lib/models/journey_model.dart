import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Journey extends Equatable {
  Journey({
    @required this.artistName,
    this.studioName = '',
    this.artistEmail = 'james.dalboth@gmail.com',
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
          name,
          mentalImage,
          size,
          position,
          email,
          availability,
          deposit
        ]);
  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      artistName: json['artist_name'],
      studioName: '',
      artistEmail: json['artist_email'],
      name: json['user_name'],
      mentalImage: json['desc'],
      size: json['size'],
      position: json['pos'],
      email: '',
      availability: '',
      deposit: '',
    );
  }

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

  Map<String, dynamic> toJson() {
    final x = <String, dynamic>{
      'artist_name': artistName,
      'artist_email': artistEmail,
      'user_name': name,
      'user_email': email,
      'studio_name': studioName,
      'tattoo_desc': mentalImage,
      'size': size,
      'position': position,
      'availability': availability,
      'deposit': deposit,
    };
    return x;
  }
}
