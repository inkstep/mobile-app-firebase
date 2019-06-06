import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  User({@required this.id, @required this.name, @required this.email})
      : super(<dynamic>[id, name, email]);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        id = json['id'];

  final int id;
  final String name;
  final String email;
}
