import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class FormResult extends Equatable {
  FormResult({
    @required this.name,
    @required this.artistID,
    @required this.description,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.images,
    @required this.style,
  }) : super(<dynamic>[name, description, size, position, email, availability, images, style]);

  final String name;
  final int artistID;
  final String description;
  final String size;
  final String position;
  final String email;
  final String availability;
  final List<Asset> images;
  final String style;
}
