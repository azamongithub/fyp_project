// import 'package:CoachBot/res/component/reusable_list_tile.dart';
// import 'package:CoachBot/utils/routes/route_name.dart';
// import 'package:CoachBot/view/account_details/profile_details_tabs/fitness_details.dart';
// import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//
// class AccountDetailsScreen extends StatelessWidget {
//   const AccountDetailsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit Profile'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ReusableListTile(
//                 title: 'Personal Details',
//                 iconData: FontAwesomeIcons.userPen,
//                 onTap: () {
//                   Navigator.pushNamed(context, RouteName.PersonalDetails);
//                 },
//               ),
//               ReusableListTile(
//                 title: 'Fitness Details',
//                 iconData: FontAwesomeIcons.weightScale,
//                 onTap: () {
//                   Navigator.pushNamed(context, RouteName.FitnessDetails);
//                 },
//               ),
//               ReusableListTile(
//                 title: 'Health Details',
//                 iconData: FontAwesomeIcons.briefcaseMedical,
//                 onTap: () {
//                   Navigator.pushNamed(context, RouteName.HealthDetails);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
