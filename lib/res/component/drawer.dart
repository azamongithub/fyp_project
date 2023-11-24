// import 'package:CoachBot/res/component/reusable_list_tile.dart';
// import 'package:CoachBot/view/Workouts/workout_screen.dart';
// import 'package:CoachBot/view/login/login_screen.dart';
// import 'package:CoachBot/view/settings/settings_tab.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// import '../../utils/routes/route_name.dart';
// import '../../view/temp.dart';
//
// class AppDrawer extends StatefulWidget {
//   const AppDrawer({Key? key}) : super(key: key);
//
//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }
//
// class _AppDrawerState extends State<AppDrawer> {
//   void logout() {
//     FirebaseAuth.instance.signOut(); // Sign out the user from Firebase Auth
//     FirebaseFirestore.instance.terminate();
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginForm()),
//     (route) => false,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: 280,
//         child: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               const UserAccountsDrawerHeader(
//                 accountName: Text('Azam Ansari'),
//                 accountEmail: Text("azamansari@gmail.com"),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundImage: NetworkImage(
//                       'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2'),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Color(0xff3140b0),
//                 ),
//               ),
//               // ReusableListTile(
//               //   title: "Account",
//               //   iconData: FontAwesomeIcons.user,
//               //   onTap: () {
//               //     Navigator.pushNamed(context, RouteName.AccountDetailsScreen);
//               //     // Navigator.push(
//               //     //     context,
//               //     //     MaterialPageRoute(
//               //     //         builder: (context) => AccountDetailsScreen()));
//               //   },
//               // ),
//               //
//               // ReusableListTile(
//               //   title: "Settings",
//               //   iconData: FontAwesomeIcons.cog,
//               //   onTap: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => SettingsScreen()));
//               //   },
//               // ),
//
//               ReusableListTile(
//                 title: "Date Of Birth Form",
//                 iconData: FontAwesomeIcons.cog,
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => DateOfBirthForm()));
//                 },
//               ),
//               // ReusableListTile(
//               //   title: "Workout Videos",
//               //   iconData: FontAwesomeIcons.cog,
//               //   onTap: () {
//               //     Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //             builder: (context) => WorkoutVideosList()));
//               //   },
//               // ),
//
//               ListTile(
//                 leading: const Icon(FontAwesomeIcons.signOutAlt),
//                 title: const Text('Logout'),
//                 onTap: () {
//                   logout();
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginForm()));
//                 },
//               ),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
