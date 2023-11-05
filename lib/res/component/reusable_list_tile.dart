import 'package:flutter/material.dart';
import 'dart:async';

class ReusableListTile extends StatefulWidget {
  final String title;
  final IconData? iconData;
  final VoidCallback? onTap;

  const ReusableListTile({
    Key? key,
    required this.title,
    this.iconData,
    this.onTap,
  }) : super(key: key);

  @override
  _ReusableListTileState createState() => _ReusableListTileState();
}

class _ReusableListTileState extends State<ReusableListTile> {
  //bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              //_isTapped = true;
            });
            Timer(Duration(milliseconds: 100), () {
              setState(() {
                //_isTapped = false;
              });
            });
            widget.onTap!();
          },
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            //tileColor: _isTapped ? Colors.indigo : null,
            //textColor: _isTapped ? Colors.white : null,
            //iconColor: _isTapped ? Colors.white : null,
            title: Text(widget.title),
            leading: Icon(widget.iconData),
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
