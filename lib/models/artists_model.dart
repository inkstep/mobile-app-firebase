import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'studio_model.dart';

class Artist extends Equatable {
  Artist({@required this.artistID, @required this.name, @required this.email, @required this
      .studio})
      : super(<dynamic>[artistID, name, email, studio]);

  final String name;
  final String email;
  final Studio studio;
  final int artistID;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'artistID': artistID, 'name': name, 'email': email, 'studio': studio};
  }
}
