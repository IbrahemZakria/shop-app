import 'package:shared_preferences/shared_preferences.dart';

class cashHelper {
  static SharedPreferences? sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putdata(
      {required String key, required dynamic value}) async {
    if (value is String) {
      return await sharedPreferences!.setString(key, value);
    } else if (value is double) {
      return await sharedPreferences!.setDouble(key, value);
    } else if (value is int) {
      return await sharedPreferences!.setInt(key, value);
    } else {
      return await sharedPreferences!.setBool(key, value);
    }
  }

  static bool? getbolean({
    required String key,
  }) {
    return sharedPreferences?.getBool(key);
  }

 

  static String? getString({required String key}) {
    return sharedPreferences?.getString(key);
  }

  static Future<bool> removedata({required String Key}) async {
    return await sharedPreferences!.remove(Key);
  }
}
