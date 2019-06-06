import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Studio extends Equatable {
  Studio({@required this.name})
      : super(<dynamic>[name]);

  factory Studio.fromJson(Map<String, dynamic> json) {
    assert(json != null);

    final String name = json['name'] ?? '';

    return Studio(name: name);
  }

  final String name;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{'name': name};
  }
}
