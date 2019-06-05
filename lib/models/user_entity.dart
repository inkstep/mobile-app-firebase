import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  UserEntity({@required this.name, @required this.email}) : super(<dynamic>[name, email]);

  final String name;
  final String email;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'user_name': name, 'user_email': email};
  }

  @override
  String toString() => 'User { name: $name, email: $email }';
}
