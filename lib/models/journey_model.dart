import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Journey extends Equatable {
  Journey({
    this.artistId = 2,
    this.userId,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.deposit,
  }) : super(<dynamic>[
          artistId,
          userId,
          mentalImage,
          size,
          position,
          email,
          availability,
          deposit
        ]);

  factory Journey.fromJson(Map<String, dynamic> json) {
    return Journey(
      userId: json['user_id'],
      artistId: json['artist_id'],
      mentalImage: json['desc'],
      size: json['size'],
      position: json['pos'],
      email: '',
      availability: '',
      deposit: '',
    );
  }

  final int artistId;
  int userId;
  final String mentalImage;
  final String size;
  final String position;
  final String email;
  final String availability;
  final String deposit;

  Map<String, dynamic> toJson() {
    final x = <String, dynamic>{
      'artist_id': artistId.toString(),
      'user_id': userId.toString(),
      'tattoo_desc': mentalImage,
      'size': size,
      'position': position,
      'availability': availability,
      'deposit': deposit,
      'ref_images': 1.toString(),
    };
    return x;
  }
}
