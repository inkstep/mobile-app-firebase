import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class FormResult extends Equatable {
  FormResult({
    @required this.name,
    @required this.artistID,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.images,
  }) : super(<dynamic>[
          name,
          mentalImage,
          size,
          position,
          email,
          availability,
          images
        ]);

  final String name;
  final int artistID;
  final String mentalImage;
  final String size;
  final String position;
  final String email;
  final String availability;
  final List<Asset> images;
}
