// import 'package:CoachBot/res/component/trailing_list_tile.dart';
// import 'package:CoachBot/utils/utils.dart';
// import 'package:CoachBot/view_model/profile/profile_controller.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
//
// class PersonalDetails extends StatelessWidget {
//   const PersonalDetails({super.key});
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//     final userProfileStream = FirebaseFirestore.instance
//         .collection('UserProfileCollection')
//         .doc(user!.uid)
//         .snapshots();
//
//     return StreamBuilder<DocumentSnapshot>(
//       stream: userProfileStream,
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//
//         if (!snapshot.hasData) {
//           return const Scaffold(
//             body: Center(child: Text('No data available')),
//           );
//         }
//
//         final ageData = snapshot.data?.data() as Map<String, dynamic>;
//         if (ageData.isEmpty) {
//           return const Center(
//             child: Text('No data available'),
//           );
//         }
//
//         final userData = snapshot.data!.data() as Map<String, dynamic>?;
//
//         return Scaffold(
//             resizeToAvoidBottomInset: false,
//             body: ChangeNotifierProvider(
//               create: (_) => ProfileController(),
//               child: Consumer<ProfileController>(
//                   builder: (context, provider, child) {
//                 return SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             Utils.negativeToastMessage(
//                                 'This field cannot be changed.');
//                           },
//                           child: ListTile(
//                             leading: const Icon(Icons.email),
//                             title: const Text('Email'),
//                             subtitle: Text(userData?['email'] ?? ''),
//                           ),
//                         ),
//                         Divider(color: Colors.grey.withOpacity(0.8)),
//                         GestureDetector(
//                           onTap: () {
//                             provider.userNameDialogAlert(
//                                 context, userData?['name']);
//                           },
//                           child: TrailingListTile(
//                             title: 'Name',
//                             trailing: Text(userData?['name'] ?? ''),
//                             iconData: FontAwesomeIcons.userLarge,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             provider.userDateOfBirthDialogAlert(
//                                 context, userData?['dateOfBirth']);
//                           },
//                           child: TrailingListTile(
//                             title: 'Date of birth',
//                             trailing: Text(userData?['dateOfBirth'] != null
//                                 ? DateFormat('yyyy-MM-dd').format(
//                                     DateTime.parse(userData!['dateOfBirth']))
//                                 : ''),
//                             iconData: FontAwesomeIcons.cakeCandles,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             Utils.positiveToastMessage(
//                                 'You can change your date of birth to update the age .');
//                           },
//                           child: TrailingListTile(
//                             title: 'Age',
//                             trailing: Text(userData?['age'] != null
//                                 ? '${userData!['age']} Years'
//                                 : ''),
//                             iconData: FontAwesomeIcons.solidCalendarDays,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             Utils.positiveToastMessage(
//                                 'You can change your date of birth to update the age group');
//                           },
//                           child: TrailingListTile(
//                             title: 'Age Group',
//                             trailing: Text(userData?['ageGroup'] ?? ''),
//                             iconData: FontAwesomeIcons.children,
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             provider.userGenderDialogAlert(
//                               context,
//                               userData?['gender'],
//                               gender: 'Gender',
//                             );
//                           },
//                           child: TrailingListTile(
//                             title: 'Gender',
//                             trailing: Text(userData?['gender'] ?? ''),
//                             iconData: FontAwesomeIcons.venusMars,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//             ));
//       },
//     );
//   }
// }
