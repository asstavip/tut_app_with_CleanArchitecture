import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/resources/color_pallete.dart';
import 'package:flutter_advanced/presentation/resources/style_manager.dart';
import 'package:flutter_advanced/presentation/resources/values_manager.dart';

import 'font_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main color of the app
    primaryColor: ColorPallete.primaryOrange,
    primaryColorLight: ColorPallete.primaryLightOrange,
    primaryColorDark: ColorPallete.primaryGray,
    //ripple color
    splashColor: ColorPallete.primaryLightOrange,

    //other colors
    disabledColor: ColorPallete.primaryGray,
    //will be used when the button is disabled

    //card view theme
    cardTheme: CardTheme(
      color: ColorPallete.primaryWhite,
      shadowColor: ColorPallete.primaryGray,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16),
      ),
    ),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorPallete.primaryOrange,
      elevation: AppSize.s4,
      shadowColor: ColorPallete.primaryGray,
      titleTextStyle: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
    ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorPallete.primaryGray,
      buttonColor: ColorPallete.primaryOrange,
      splashColor: ColorPallete.primaryLightOrange,
    ),

    // elevation button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPallete.primaryOrange,
        textStyle: getRegularStyle(color: ColorPallete.primaryWhite),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getSemiBoldStyle(
          color: ColorPallete.gray, fontSize: FontSizeManager.s16),
      displayMedium: getMediumStyle(
          color: ColorPallete.lightGray, fontSize: FontSizeManager.s16),
      displaySmall: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineLarge: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineMedium: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineSmall: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleLarge: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleMedium: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleSmall: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodyLarge: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodyMedium: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodySmall: getRegularStyle(
          color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
    ),

    //input decoration theme(text from fields)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      fillColor: ColorPallete.primaryWhite,
      filled: true,
      prefixIconColor: ColorPallete.primaryOrange,
      suffixIconColor: ColorPallete.primaryOrange,
      hintStyle: getRegularStyle(color: ColorPallete.primaryGray),
      labelStyle: getRegularStyle(color: ColorPallete.primaryWhite),
      errorStyle: getRegularStyle(color: ColorPallete.errorRed),
      enabledBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorPallete.primaryGray, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorPallete.primaryOrange, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorPallete.errorRed, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorPallete.primaryOrange, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
