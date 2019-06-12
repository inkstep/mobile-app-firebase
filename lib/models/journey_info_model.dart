import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class JourneyInfo extends Equatable {
  JourneyInfo({
    @required this.userName,
    @required this.userEmail,
    this.artistId = 2,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.availability,
    @required this.images,
  }) : super(<dynamic>[
          userName,
          userEmail,
          artistId,
          mentalImage,
          size,
          position,
          availability,
          images
        ]);

  final String userName;
  final String userEmail;
  int artistId;
  final String mentalImage;
  final String size;
  final String position;
  final String availability;
  final List<Asset> images;
}
