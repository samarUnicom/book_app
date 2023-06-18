import 'package:book_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  primaryColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: ThemeColor.whiteColors,
      centerTitle: true,
    ),
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ThemeColor.secondprimaryColor,
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(color: ThemeColor.secondprimaryColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: ThemeColor.secondprimaryColor,
      foregroundColor: ThemeColor.secondprimaryColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: TextStyle(color: ThemeColor.secondprimaryColor),
        iconColor: ThemeColor.secondprimaryColor,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColor.secondprimaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ThemeColor.secondprimaryColor),
          borderRadius: BorderRadius.circular(8),
        )));
