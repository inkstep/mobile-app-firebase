import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Equatable {

  static String usernameKey = 'name';

  static Future<bool> exists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(usernameKey);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(usernameKey);
    return name ?? 'No saved username'; // TODO(mm): handle something better here
  }

  static void setName(String username) async {
    if (username != '') {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(usernameKey, username);
    }
  }

  static void logOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(usernameKey);
  }

  UserModel({@required this.id, @required this.name, @required this.email})
      : super(<dynamic>[id, name, email]);

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        id = json['id'];

  final int id;
  final String name;
  String email;
}
