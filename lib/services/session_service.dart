import 'package:shared_preferences/shared_preferences.dart';

class SessionService {

  static Future<void> saveLogin() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("isLogin", true);
  }

  static Future<void> logout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
  }

  static Future<bool> isLogin() async {
    final pref = await SharedPreferences.getInstance();

    return pref.getBool("isLogin") ?? false;
  }
}