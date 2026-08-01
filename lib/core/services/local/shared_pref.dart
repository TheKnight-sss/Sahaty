import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences pref;

  static const String kadminData = "adminDate";
  static const String kcoRepData = "coRepDate";

  static Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }

  static void saveData(String key, dynamic value) {
    if (value is int) {
      pref.setInt(key, value);
    } else if (value is String) {
      pref.setString(key, value);
    } else if (value is bool) {
      pref.setBool(key, value);
    } else if (value is double) {
      pref.setDouble(key, value);
    }
  }

 static dynamic getData(String key) {
    return pref.get(key);
  }

 static Future<void> remove(String key) async {
    await pref.remove(key);
  }
}
