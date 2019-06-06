import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Artist extends Equatable {
  Artist({@required this.name, @required this.email, @required this.studio})
      : super(<dynamic>[name, email, studio]);

  factory Artist.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final String name = json['name'] ?? '';
    final String email = json['email'] ?? '';
    final String studio = json['studio'] ?? '';

    return Artist(name: name, email: email, studio: studio);
  }
  final String name;
  final String email;
  final String studio;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email, 'studio': studio};
  }
}
