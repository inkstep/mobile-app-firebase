import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Equatable {

  UserModel({@required this.id, @required this.name, @required this.email})
      : super(<dynamic>[id, name, email]);

  UserModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        id = json['id'];

  static String usernameKey = 'name';
  static String emailKey = 'email';

  static Future<bool> exists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(usernameKey);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(usernameKey);
    return name ?? 'No saved username'; // TODO(mm): handle something better here
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  static Future<bool> setName(String username) async {
    if (username == '') {
      return Future.value(false);
    }
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(usernameKey, username);
  }

  static Future<bool> logOut() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(usernameKey);
  }

  final int id;
  final String name;
  String email;
}
