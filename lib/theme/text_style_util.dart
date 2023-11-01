// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'color_util.dart';
//
// class textStyleUtil {
//
//   // Optional Values
//
//   static TextStyle customText30(Color? color, {FontWeight? fontWeight} {FontFamily? fontFamily}) {
//     return TextStyle(
//       fontStyle: FontStyle.normal,
//       fontSize: 30.sp,
//       fontWeight: fontWeight,
//       fontFamily: 'Roboto',
//       color: color ?? ColorUtil.smallText,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'color_util.dart';

class MyTextStyle {

  static TextStyle customTitleStyle({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: ColorUtil.titleColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    );
  }

  static TextStyle customTextStyle({
    Color? color,
    FontWeight? fontWeight,
    String? fontFamily,
    double? fontSize,
  }) {
    return TextStyle(
      color: ColorUtil.titleColor,
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
    );
  }





}

// Example usage:
// TextStyle myTextStyle = MyTextStyle.customText30(Colors.black, fontWeight: FontWeight.bold, fontFamily: 'YourCustomFont');
