import 'package:equatable/equatable.dart';

class Journey extends Equatable {
  Journey(this.artistName, this.studioName)
      : super(<dynamic>[artistName, studioName]);

  Journey.fromJson(Map<String, dynamic> json)
      : artistName = json['artist'],
        studioName = json['studio'];

  final String artistName;
  final String studioName;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'artist': artistName,
      'studio': studioName,
    };
  }
}
