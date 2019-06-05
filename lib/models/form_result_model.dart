import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class FormResult extends Equatable {
  FormResult({
    @required this.name,
    @required this.mentalImage,
    @required this.size,
    @required this.position,
    @required this.email,
    @required this.availability,
    @required this.deposit,
  }) : super(<dynamic>[
          name,
          mentalImage,
          size,
          position,
          email,
          availability,
          deposit
        ]);

  final String name;
  final String mentalImage;
  final String size;
  final String position;
  final String email;
  final String availability;
  final String deposit;
}
