import 'package:flutter/material.dart';
import 'package:flutter_advanced/presentation/color_pallete.dart';
import 'package:flutter_advanced/presentation/style_manager.dart';
import 'package:flutter_advanced/presentation/values_manager.dart';
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
    disabledColor: ColorPallete.primaryGray,//will be used when the button is disabled

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
      titleTextStyle: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
    ),

    //button theme
    buttonTheme: ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorPallete.primaryGray,
      buttonColor: ColorPallete.primaryOrange,
    ),
    //text theme
    textTheme: TextTheme(
      displayLarge: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      displayMedium: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      displaySmall: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineLarge: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineMedium: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      headlineSmall: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleLarge: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleMedium: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      titleSmall: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodyLarge: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodyMedium: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
      bodySmall: getRegularStyle(color: ColorPallete.primaryWhite, fontSize: FontSizeManager.s16),
    ),
    //input decoration theme(text from fields)
  );
}