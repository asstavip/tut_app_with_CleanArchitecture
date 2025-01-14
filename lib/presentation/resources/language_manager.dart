import 'package:flutter_advanced/presentation/resources/strings_manager.dart';

enum LanguageType { ENGLISH, ARABIC }

const String arabic = 'ar';
const String english = 'en';

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
