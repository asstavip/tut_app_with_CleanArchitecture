import 'package:flutter/material.dart';

class ColorPallete {
  static const Color primaryOrange = Color(0xFFED9728);
  static const Color primaryLightOrange = Color(0xFFFFD2A6);
  static const Color primaryGray = Color(0xFF525252);
  static const Color gray = Color(0xFF9E9E9E);
  static const Color lightGray = Color(0xFF737477);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static Color secondaryWhite = colorFromHex('#F5F5F5');
  static const Color errorRed = Color(0xFFE61F34);
  static const Color black = Color(0xFF000000);
  static const Color transparentBlack = Colors.black26;
  static const Color transparent = Colors.transparent;
  static const Color success = Colors.green;
}

Color colorFromHex(String hexColor) {
  /// convert hex color string to Color and returns Color
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
