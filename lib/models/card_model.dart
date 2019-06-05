import 'package:equatable/equatable.dart';

class CardModel extends Equatable {
  CardModel(this.description, this.artistName) : super(<dynamic>[description, artistName]);

  String description;
  String artistName;
}
