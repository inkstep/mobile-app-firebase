import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  User({@required this.name, @required this.email})
      : super(<dynamic>[name, email]);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'];

  final String name;
  final String email;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email};
  }
}
