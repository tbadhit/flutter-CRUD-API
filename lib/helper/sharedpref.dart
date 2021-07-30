import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  save(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? prefString = prefs.getString(key);

    if (prefString == null) {
      return json.decode('false');
    } else {
      return json.decode(prefString);
    }
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
