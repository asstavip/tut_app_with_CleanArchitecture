import 'package:flutter/material.dart';

enum LanguageType { ENGLISH, ARABIC }

const String arabic = 'ar';
const String english = 'en';
const String assetsPath = 'assets/translations';

const Locale englishLocale = Locale('en', 'US');
const Locale arabicLocale = Locale('ar', 'SA');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return english;
      case LanguageType.ARABIC:
        return arabic;
    }
  }
}
