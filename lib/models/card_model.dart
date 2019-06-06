import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CardModel extends Equatable {
  CardModel(this.description, this.artistName, this.images) : super(<dynamic>[description,
  artistName, images]);

  String description;
  String artistName;
  List<Image> images;
}
