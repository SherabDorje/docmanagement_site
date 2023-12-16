import 'package:flutter/material.dart';

enum MagicStrings {
  imgLogo,
  customer,
  projectName,
  modelPlan,
  city,
  jobAddress,
  bidPlan,
  phone,
  attn,
  price,
  equipment,
  ton,
  seer,
  hspf,
  elecHeat,
}

class Constants {
  static const String googleAPIKey = "AIzaSyD9kSgSKcFJL4oiHheRhxmErpkrvLH12F4";

  //Magic strings

  static const bgColor = Color(0xFFFFFFFF);
// Colors
  static const MaterialColor themeBlack = MaterialColor(
    themeBlackPrimaryValue,
    <int, Color>{
      50: Color(themeBlackPrimaryValue),
      100: Color(themeBlackPrimaryValue),
      200: Color(themeBlackPrimaryValue),
      300: Color(themeBlackPrimaryValue),
      400: Color(themeBlackPrimaryValue),
      500: Color(themeBlackPrimaryValue),
      600: Color(themeBlackPrimaryValue),
      700: Color(themeBlackPrimaryValue),
      800: Color(themeBlackPrimaryValue),
      900: Color(themeBlackPrimaryValue),
    },
  );
  static const int themeBlackPrimaryValue = 0xFF222222;
  static const Color themeTextPrimary = Color(0xFF9D9D9D);

  static const Color primaryColor = Color.fromRGBO(103, 77, 167, 1);
  static const Color secondaryColor = Color.fromRGBO(170, 148, 231, 1);

  static const Color activeMenuColor = Color.fromRGBO(255, 255, 255, 1);
  static const Color inactivemenuColor = Color.fromRGBO(155, 155, 155, 1);

  static const Color headerWinColor = Color.fromRGBO(9, 180, 247, 1);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color secondaryText = Color(0xFF888888);
  static const Color inputBgColor = Color(0xFFF6F6F6);
  static const Color inputBorderColor = Color(0xFFE8E8E8);
  static const Color shadowColor = Color.fromRGBO(0, 0, 0, 0.25);
  static const Color inactiveColor = Color.fromRGBO(176, 153, 187, 1);
  static const Color testColor = Color.fromARGB(255, 255, 17, 0);
  static LinearGradient primaryGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primaryColor, secondaryColor]);
  static const Color red = Color(0xFF9C0000);
  static const Color grey1 = Color(0xFFebedef);
  static const Color grey2 = Color(0xFFDFE2E5);
  // static const Color grey2 = Color(0xFFDFE2E5);
  static const Color grey3 = Color(0xFFAAACAE);
  static const Color grey4 = Color(0xFF888888);
  static const Color background = Color(0xFFF3F3FA);
  static const Color black = Color(0xFF2A3037);
  static Color barrierColor = Colors.black.withOpacity(0.5);

  static const Color green = Color(0xFF8BC34A);

  static LinearGradient darkGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [dark2, dark1]);
  static const Color dark1 = Color(0xFF212121);
  static const Color dark2 = Color(0xFF424242);

  static LinearGradient lightGradient = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [grey4, dark2]);

  // Font family
  static const String fontFamilyApp = 'Roboto';
}
