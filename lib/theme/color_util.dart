import 'package:flutter/material.dart';

abstract class AppColors {
  static const LinearGradient themeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xffFF5F6D),
      Color(0xff3140b0),
    ],
  );

  static const Color themeColor = Color(0xff3140b0);
  static const Color successColor = Color(0xff04cd62);
  static const Color alertColor = Color(0xffff0222);
  static const Color inputTextBorderColor = Color.fromRGBO(19, 103, 33, 1);
  static const Color hintColor = Color.fromRGBO(114, 114, 114, 1);
  static const Color titleColor = Color(0xff203142);
  static const Color subTitleColor = Color(0xff8F92A1);
  static const Color blackColor = Color(0xff000000);
  static const Color whiteColor = Color(0xffF6F6FA);
}
