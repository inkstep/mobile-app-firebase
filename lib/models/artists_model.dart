import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'studio_model.dart';

class Artist extends Equatable {
  Artist({@required this.name, @required this.email, @required this.studio})
      : super(<dynamic>[name, email, studio]);

  final String name;
  final String email;
  final Studio studio;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name, 'email': email, 'studio': studio};
  }
}
