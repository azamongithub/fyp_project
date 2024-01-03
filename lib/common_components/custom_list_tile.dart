import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color_util.dart';
import '../theme/text_style_util.dart';

class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;
  final IconData? iconData;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.trailing,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 2,
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: title,
              subtitle: subTitle,
              leading: Icon(
                iconData,
                size: 20.sp,
                  color: AppColors.themeColor
              ),
              trailing: trailing,
            ),
          ),
        ),
        SizedBox(height:8.h),
        // Divider(
        //   color: Colors.grey[300],
        //   thickness: 1,
        // ),
      ],
    );
  }
}
