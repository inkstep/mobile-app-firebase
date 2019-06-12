import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class EmptyJourneyEntity extends Equatable {
  EmptyJourneyEntity({
    @required this.userId,
    @required this.artistId,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.noImages,
  }) : super(<dynamic>[
          userId,
          artistId,
          mentalImage,
          size,
          position,
          availability,
          noImages,
        ]);

  factory EmptyJourneyEntity.fromJson(Map<String, dynamic> json) {
    return EmptyJourneyEntity(
      userId: json['userID'],
      artistId: json['artistID'],
      mentalImage: json['tattooDesc'],
      size: json['size'],
      position: json['position'],
      availability: json['availability'],
      noImages: int.parse(json['noRefImages'])
    );
  }

  final int userId;
  final int artistId;
  final String mentalImage;
  final String size;
  final String position;
  final String availability;
  final int noImages;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userID': userId,
      'artistID': artistId,
      'tattooDesc': mentalImage,
      'size': size,
      'position': position,
      'availability': availability,
      'noRefImages': noImages,
    };
  }
}
