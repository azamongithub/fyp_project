import 'package:CoachBot/theme/text_style_util.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final Widget title;
  final Widget? trailing;
  final IconData? iconData;
  final VoidCallback? onTap;

  const CustomListTile({
    Key? key,
    required this.title,
    this.trailing,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: title,
            leading: Icon(
              iconData,
              size: 20,
            ),
            trailing: trailing,
          ),
        ),
        Divider(
          color: Colors.grey[300],
          thickness: 1,
        ),
      ],
    );
  }
}
