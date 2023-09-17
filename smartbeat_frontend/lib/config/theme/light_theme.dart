import 'package:flutter/material.dart';
import 'package:smartbeat_frontend/shared/utils/app_colors.dart';

ThemeData lightTheme = ThemeData.from(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    background: AppColors.background,
    outlineVariant: AppColors.outlineVariant,
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontFamily: 'Open Sans',
      fontWeight: FontWeight.normal,
      fontSize: 30,
    ),
      titleLarge: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 20,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 17.5,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.normal,
        fontSize: 13.5,
        color: AppColors.textInputColor
      ),
      displayMedium: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w800,
        fontSize: 17.5,
          color: AppColors.textInputColor
      ),
      displayLarge: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.bold,
        fontSize: 30,
      )),
).copyWith(
  dialogBackgroundColor: Colors.white,
  dialogTheme: const DialogTheme(
    backgroundColor: Colors.white,
  ),
  //cardTheme
  //datePickerTheme
  //bottomNavigationBarTheme:
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: AppColors.secondary,
    unselectedItemColor: AppColors.primary,
    selectedItemColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Open Sans',
      fontWeight: FontWeight.w600,
    ),
    selectedLabelStyle: TextStyle(
      fontFamily: 'Open Sans',
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  //appBarTheme
  //switchTheme
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      textStyle: const TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w800,
        fontSize: 17.5,
      ),
      side: const BorderSide(
        width: 2.0,
        color: AppColors.secondary,
      ),
      elevation: 2.5,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 17.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white.withOpacity(0.75),
      foregroundColor: AppColors.secondary,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontFamily: 'Open Sans',
        fontWeight: FontWeight.w800,
        fontSize: 17.5,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 17.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      disabledForegroundColor: Colors.white,
      disabledBackgroundColor: AppColors.outlineVariant,
      elevation: 2.5,
      shadowColor: AppColors.outlineVariant,
    ),
  ),
  //inputDecorationTheme
  textButtonTheme: const TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.all(0.0),
      ),
      textStyle: MaterialStatePropertyAll<TextStyle>(
        TextStyle(
          fontFamily: 'Open Sans',
          fontSize: 17.0,
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline
        ),
      ),
      foregroundColor: MaterialStatePropertyAll(AppColors.primary),
      overlayColor: MaterialStatePropertyAll(Colors.transparent),
    ),
  ),
);
