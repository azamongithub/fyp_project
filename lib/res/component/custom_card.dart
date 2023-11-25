import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback? onTap;

  CustomCard({required this.title, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: isSelected ? 5 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: 500,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: isSelected ? Colors.green : Colors.grey,
                width: isSelected ? 2 : 0,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 15.h),
              child: Text(
                title,
                style: MyTextStyle.textStyle22(), // Update with your text style
              ),
            ),
          ),
        ),
      ),
    );
  }
}
