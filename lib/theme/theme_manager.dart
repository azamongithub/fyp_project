import 'package:flutter/material.dart';
import 'color_util.dart';

class ThemeManager {

  //static const String fontFamily = 'Poppins';

  static ThemeData lightTheme = ThemeData(
     brightness: Brightness.light,

    appBarTheme: const AppBarTheme(
      color: AppColors.themeColor,
      iconTheme: IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    iconTheme: const IconThemeData(
        color: AppColors.themeColor
    ),
  );

  static ThemeData darkTheme = ThemeData(
     brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Colors.grey[900],
      iconTheme: const IconThemeData(
        color: AppColors.whiteColor,
      ),
    ),
    iconTheme: const IconThemeData(
        color: AppColors.themeColor
    ),
  );
}
