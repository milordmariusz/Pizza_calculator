import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static SharedPreferences? _preferences;

  static const _keyCurrency = 'currency';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setCurrency(String currency) async =>
      await _preferences!.setString(_keyCurrency, currency);

  static String? getCurrency() => _preferences!.getString(_keyCurrency);
}