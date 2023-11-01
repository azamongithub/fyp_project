import 'package:flutter/material.dart';
import 'dart:async';

class TrailingListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Widget trailing;

  const TrailingListTile(
      {Key? key,
        required this.title,
        required this.iconData,
        required this.trailing,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: Icon(iconData , size: 20,),
          trailing: trailing,
        ),
        Divider(color: Colors.grey.withOpacity(0.6)),
      ],
    );

  }
}