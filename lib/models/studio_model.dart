import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Studio extends Equatable {
  Studio({@required this.name, @required this.id}) : super(<dynamic>[name, id]);

  factory Studio.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final String name = json['name'] ?? '';
    final String id = json['id'] ?? '';

    return Studio(name: name, id: int.parse(id));
  }

  final String name;
  final int id;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'id': id, 'name': name};
  }
}
