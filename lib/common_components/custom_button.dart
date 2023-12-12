import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color, textColor;
  final bool loading;

  const CustomButton(
      {Key? key,
      required this.title,
      required this.onTap,
      this.loading = false,
      this.color = Colors.black,
        this.textColor = Colors.black,
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading? null : onTap,
      child: Container(
        height: 50.h,
        width: 400.w,
        decoration: BoxDecoration(
          color: ColorUtil.themeColor,
          borderRadius: BorderRadius.circular(50),

        ),
        child: Center(
          child: loading
              ? const Center(child: CircularProgressIndicator(strokeWidth: 3 , color: ColorUtil.whiteColor))
              : Text(
                  title,
                  style: CustomTextStyle.textStyle20(
                    color: ColorUtil.whiteColor
                  ),
                ),
        ),
      ),
    );
  }
}
