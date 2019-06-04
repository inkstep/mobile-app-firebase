import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Journey extends Equatable {
  Journey({
    this.artist_id = 2,
    this.user_id,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.deposit,
  }) : super(<dynamic>[
          artist_id,
          user_id,
          mentalImage,
          size,
          position,
          email,
          availability,
          deposit
        ]);

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      user_id: json['user_id'],
      artist_id: json['artist_id'],
      mentalImage: json['desc'],
      size: json['size'],
      position: json['pos'],
      email: '',
      availability: '',
      deposit: '',
    );
  }

  final int artist_id;
  int user_id;
  final String mentalImage;
  final String size;
  final String position;
  final String email;
  final String availability;
  final String deposit;

  Map<String, dynamic> toJson() {
    final x = <String, dynamic>{
      'artist_id': artist_id,
      'user_id': user_id,
      'tattoo_desc': mentalImage,
      'size': size,
      'position': position,
      'availability': availability,
      'deposit': deposit,
      'ref_images': 1,
    };
    return x;
  }
}
