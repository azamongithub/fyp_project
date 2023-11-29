import 'package:flutter/material.dart';

import '../../theme/text_style_util.dart';

class AiTrainerTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: Text('AI Trainer ', style: MyTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'General Settings',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       SwitchListTile(
      //         title: Text('Notification'),
      //         value: true, // Replace with actual value and implement functionality
      //         onChanged: (value) {
      //           // Action to toggle notification setting
      //         },
      //       ),
      //       SwitchListTile(
      //         title: Text('Dark Mode'),
      //         value: false, // Replace with actual value and implement functionality
      //         onChanged: (value) {
      //           // Action to toggle dark mode setting
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       Text(
      //         'Account Settings',
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //       SizedBox(height: 20),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text('Profile'),
      //         onTap: () {
      //           // Action when Profile is tapped
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.lock),
      //         title: Text('Change Password'),
      //         onTap: () {
      //           // Action when Change Password is tapped
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.delete),
      //         title: Text('Delete Account'),
      //         onTap: () {
      //           // Action when Delete Account is tapped
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}