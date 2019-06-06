import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class StudioEntity extends Equatable {
  StudioEntity({@required this.name})
      : super(<dynamic>[name]);

  factory StudioEntity.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final String name = json['name'] ?? '';

    return StudioEntity(name: name);
  }

  final String name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name};
  }
}
