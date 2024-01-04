import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutsListTile extends StatelessWidget {
  final Widget title;
  final Widget? subTitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  const WorkoutsListTile({
    Key? key,
    required this.title,
    this.subTitle,
    this.leading,
    this.trailing,
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
              leading: leading,
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
