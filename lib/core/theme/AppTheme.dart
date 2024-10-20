import 'package:flutter/material.dart';
import 'package:skeleton/core/theme/AppColors.dart';
import 'package:skeleton/core/theme/AppDialogStyle.dart';
import 'package:skeleton/core/theme/AppTextStyle.dart';

final ThemeData lightTheme = ThemeData(
  listTileTheme: const ListTileThemeData(
    tileColor: primaryColor,
    textColor: textColor,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    dense: true,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    primary: accentColor, // 다이얼로그 기본 확인 버튼
    secondary: Colors.green,
  ),
  appBarTheme: const AppBarTheme(
    color: primaryColor,
    iconTheme: IconThemeData(
      color: primaryColor,
    ),
    titleTextStyle: black16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodySmall: black12TextStyle,
    bodyMedium: black12TextStyle,
    bodyLarge: black16TextStyle,
    labelSmall: grey13TextStyle,
    labelMedium: black16TextStyle,
    labelLarge: black16TextStyle,
    titleSmall: black12BoldTextStyle,
    titleMedium: black12BoldTextStyle,
    titleLarge: black16TextStyle,
    displaySmall: grey13TextStyle,
    displayMedium: black16TextStyle,
    displayLarge: black16TextStyle,
    headlineSmall: black12BoldTextStyle,
    headlineMedium: black12BoldTextStyle,
    headlineLarge: black16TextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: accentColor.withOpacity(0.1),
  scaffoldBackgroundColor: primaryColor,
);

final ThemeData darkTheme = ThemeData(
  listTileTheme: const ListTileThemeData(
    tileColor: primaryDarkColor,
    textColor: darkTextColor,
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    horizontalTitleGap: 0,
    minVerticalPadding: 0,
    dense: true,
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    primary: Colors.red,
    secondary: Colors.blue,
  ),
  appBarTheme: const AppBarTheme(
    color: primaryDarkColor,
    iconTheme: IconThemeData(
      color: accentDarkColor,
    ),
    titleTextStyle: white16BoldTextStyle,
  ),
  textTheme: const TextTheme(
    bodySmall: white12TextStyle,
    bodyMedium: white12TextStyle,
    bodyLarge: white16TextStyle,
    labelSmall: grey13TextStyle,
    labelMedium: white16TextStyle,
    labelLarge: white16TextStyle,
    titleSmall: white12BoldTextStyle,
    titleMedium: white12BoldTextStyle,
    titleLarge: white16TextStyle,
    displaySmall: grey13TextStyle,
    displayMedium: white16TextStyle,
    displayLarge: white16TextStyle,
    headlineSmall: white12BoldTextStyle,
    headlineMedium: white12BoldTextStyle,
    headlineLarge: white16TextStyle,
  ),
  extensions: const <ThemeExtension<dynamic>>{
    DialogStyle(),
  },
  dividerColor: accentColor.withOpacity(0.1),
  scaffoldBackgroundColor: primaryDarkColor,
);
