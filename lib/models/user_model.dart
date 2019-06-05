import 'package:meta/meta.dart';

class User {
  User({@required this.id, @required this.name, @required this.email});

  final int id;
  final String name;
  final String email;
}
