import 'package:flutter_advanced/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_LANGUAGE = "PREF_KEY_LANGUAGE";

class AppPreferences {
  SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANGUAGE);
    return language ?? LanguageType.ENGLISH.getValue();
  }
}
