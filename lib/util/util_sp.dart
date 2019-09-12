/// function: util_sp
/// <p>Created by Leo on 2019/5/16.</p>
///
import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static void putString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? "";
  }
}
