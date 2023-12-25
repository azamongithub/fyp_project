import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color color, textColor;
  final bool loading;
  final double height;
  final double width;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.loading = false,
    this.color = Colors.black,
    this.textColor = Colors.black,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.themeColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(
                      strokeWidth: 3, color: AppColors.whiteColor))
              : Text(
                  title,
                  style:
                      CustomTextStyle.textStyle20(color: AppColors.whiteColor),
                ),
        ),
      ),
    );
  }
}
