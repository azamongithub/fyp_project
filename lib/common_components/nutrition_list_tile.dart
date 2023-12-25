import 'package:flutter/material.dart';

class NutritionListTile extends StatelessWidget {
  final Widget title;
  final Widget trailing;

  const NutritionListTile(
      {Key? key, required this.title, required this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: title,
          trailing: trailing,
        ),
        Divider(color: Colors.grey.withOpacity(0.6)),
      ],
    );
  }
}
