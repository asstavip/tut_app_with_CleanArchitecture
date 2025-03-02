import 'dart:ui';

import 'package:flutter_advanced/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREF_KEY_LANGUAGE = "PREF_KEY_LANGUAGE";
const String PREF_KEY_IS_USER_LOGGED_IN = "PREF_KEY_IS_USER_LOGGED_IN";
const String PREF_KEY_IS_ONBOARDING_VIEWED = "PREF_KEY_IS_ONBOARDING_VIEWED";
const String PREF_KEY_IS_USER_REGISTERED = "PREF_KEY_IS_USER_REGISTERED";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREF_KEY_LANGUAGE);
    return language ?? LanguageType.ENGLISH.getValue();
  }

  Future<void> setAppLanguage(String language) async {
    _sharedPreferences.setString(PREF_KEY_LANGUAGE, language);
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      //set arabic
      await setAppLanguage(LanguageType.ARABIC.getValue());
    } else {
      //set english
      await setAppLanguage(LanguageType.ENGLISH.getValue());
    }
  }
  Future<Locale> getLocale() async {
    String currentLanguage = await getAppLanguage();
    if (currentLanguage == LanguageType.ENGLISH.getValue()) {
      return englishLocale;
    } else {
      return arabicLocale;
    }
  }

  Future<void> setOnboardingViewed() async {
    _sharedPreferences.setBool(PREF_KEY_IS_ONBOARDING_VIEWED, true);
  }

  Future<bool> isOnboardingViewed() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_ONBOARDING_VIEWED) ?? false;
  }

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREF_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> setUserRegistered() async {
    _sharedPreferences.setBool(PREF_KEY_IS_USER_REGISTERED, true);
  }

  Future<bool> isUserRegistered() async {
    return _sharedPreferences.getBool(PREF_KEY_IS_USER_REGISTERED) ?? false;
  }

  Future<void> logout() async {
    _sharedPreferences.remove(PREF_KEY_IS_USER_LOGGED_IN);
  }
}
