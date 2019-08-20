import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Studio extends Equatable {
  Studio({
    @required this.name,
    @required this.id,
  }) : super(<dynamic>[name, id]);

  final String name;
  final int id;
}
