import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Journey extends Equatable {
  Journey({
    @required this.artistName,
    this.studioName = '',
    this.artistEmail = 'daniel@hails.info',
    this.type = '',
    @required this.name,
    @required this.mentalImage,
    @required this.size,
    this.position = '',
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
      : artistName = json['artistName'],
        studioName = '',
        artistEmail = json['artistEmail'],
        name = json['userName'],
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
    return <String, dynamic>{
      'artistName': artistName,
      'artistEmail': artistEmail,
      'userName': name,
      'tattoo': type,
      'desc': mentalImage,
      'size': size,
      'pos': position,
    };
  }
}
