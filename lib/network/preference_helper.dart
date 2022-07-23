import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static Future<String?> getToken() async {
    String? value;
    SharedPreferences pref = await SharedPreferences.getInstance();
    value = pref.get("token") as String?;
    if (value?.isEmpty ?? true) {
      return null;
    } else {
      value = pref.get("token") as String?;
      return value;
    }
  }
}
