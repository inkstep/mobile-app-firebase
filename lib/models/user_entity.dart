import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  UserEntity({
    @required this.name,
    @required this.email,
    @required this.token,
  }) : super(<dynamic>[name, email, token]);

  final String name;
  final String email;
  final String token;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'user_name': name,
      'user_email': email,
      'token': token,
    };
  }

  @override
  String toString() => 'User { name: $name, email: $email, token: $token}';
}
