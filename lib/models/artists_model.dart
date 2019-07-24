import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'studio_model.dart';

class Artist extends Equatable {
  Artist({
    @required this.artistID,
    @required this.name,
    @required this.email,
    @required this.studio,
    @required this.profileImage,
  }) : super(<dynamic>[artistID]);

  final String name;
  final String email;
  final Studio studio;
  Widget profileImage;
  final int artistID;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'artistID': artistID, 'name': name, 'email': email, 'studio': studio};
  }
}
