import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Artist extends Equatable {
  Artist({@required this.name, @required this.email, @required this.studio})
      : super(<dynamic>[name, email, studio]);

  Artist.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        studio = json['studio'];

  final String name;
  final String email;
  final String studio;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email, 'studio': studio};
  }
}
