import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'color_util.dart';

class CustomTextStyle {
  //For AppBar
  static TextStyle appBarStyle({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: AppColors.whiteColor,
      fontSize: 22.sp,
      //fontWeight: FontWeight.bold,
    );
  }

  //For Heading 1 Text
  static TextStyle headingStyle32({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: AppColors.titleColor,
      fontSize: 32.sp,
      fontWeight: FontWeight.bold,
    );
  }

  //For Title Text
  static TextStyle titleStyle20({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? letterSpacing,
    //double? fontSize,
  }) {
    return TextStyle(
      fontSize: 20.sp,
      color: AppColors.titleColor,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
    );
  }

  //For Sub Title Text
  static TextStyle subTitleStyle14({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: AppColors.subTitleColor,
      fontSize: 14.sp,
      fontWeight: fontWeight,
    );
  }

// For text 10
  static TextStyle textStyle10({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? fontSize,
    TextStyle? style,
    bool underline = false,
  }) {
    TextStyle baseStyle = TextStyle(
      color: color,
      fontSize: fontSize ?? 10.sp,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
    );
    return underline
        ? baseStyle
            .merge(const TextStyle(
              decoration: TextDecoration.underline,
            ))
            .merge(style)
        : baseStyle.merge(style);
  }

  //For text 11
  static TextStyle textStyle11({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: AppColors.titleColor,
      fontSize: 11.sp,
      fontWeight: fontWeight,
    );
  }

  //For text 14
  static TextStyle textStyle14({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: color,
      fontSize: 14.sp,
      fontWeight: fontWeight,
    );
  }

  //For text 16
  static TextStyle textStyle16({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: AppColors.titleColor,
      fontSize: 16.sp,
      fontWeight: fontWeight,
    );
  }

  //For text 18
  static TextStyle textStyle18({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: color,
      fontSize: 18.sp,
      fontWeight: fontWeight,
    );
  }

  // //For text 20
  static TextStyle textStyle20({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: color,
      fontSize: 20.sp,
      fontWeight: fontWeight,
    );
  }

  //For text 22
  static TextStyle textStyle22({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: color,
      fontSize: 22.sp,
      fontWeight: fontWeight,
    );
  }

  //For text 24
  static TextStyle textStyle24({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: color,
      fontSize: 24.sp,
      fontWeight: fontWeight,
    );
  }

  //For Custom Text
  static TextStyle customTextStyle({
    Color? color,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    String? fontFamily,
    double? fontSize,
    double? letterSpacing,
    TextStyle? style,
    bool underline = false,
  }) {
    TextStyle baseStyle = TextStyle(
      color: color,
      fontSize: fontSize ?? 10.sp,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontFamily: fontFamily,
      letterSpacing: letterSpacing,
    );
    return underline
        ? baseStyle
            .merge(const TextStyle(
              decoration: TextDecoration.underline,
            ))
            .merge(style)
        : baseStyle.merge(style);
  }
}
