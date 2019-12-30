import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends Equatable {
  User({
    @required this.id,
    @required this.name,
  }) : super(<dynamic>[id, name]);

  static String usernameKey = 'name';
  static String emailKey = 'email';

  static Future<bool> exists() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(usernameKey);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString(usernameKey);
    return name ?? '';
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
}
