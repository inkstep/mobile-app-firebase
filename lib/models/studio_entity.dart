import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class StudioEntity extends Equatable {
  StudioEntity({@required this.id, @required this.name})
      : super(<dynamic>[id, name]);

  factory StudioEntity.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    print(json);

    final String name = json['name'] ?? '';
    final int id = json['id'] ?? '';

    return StudioEntity(id: id, name: name);
  }

  final String name;
  final int id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}
