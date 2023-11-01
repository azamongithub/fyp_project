// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_project/res/component/drawer.dart';
// // import 'package:firebase_project/res/component/list_tile1.dart';
// // import 'package:flutter/material.dart';
// //
// // class ProfileDetailsScreen extends StatelessWidget {
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final String userEmail = FirebaseAuth.instance.currentUser?.email ?? '';
// //     final Stream<QuerySnapshot> profileDataStream = FirebaseFirestore.instance
// //         .collection('userProfileCollection')
// //         .where('email', isEqualTo: userEmail)
// //         .snapshots();
// //     Map<String, dynamic> _userData = {};
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: profileDataStream,
// //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //         if (snapshot.hasError) {
// //           return Scaffold(
// //             body: Center(
// //               child: Text('Error occurred: ${snapshot.error}'),
// //             ),
// //           );
// //         }
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Scaffold(
// //             body: Center(
// //               child: CircularProgressIndicator(),
// //             ),
// //           );
// //         }
// //
// //         final List storeProfileDocs =
// //         snapshot.data!.docs.map((DocumentSnapshot document) {
// //           Map a = document.data() as Map<String, dynamic>;
// //           return a;
// //         }).toList();
// //
// //
// //
// //         if (storeProfileDocs.isEmpty) {
// //           return const Scaffold(
// //             body: Center(
// //               child: Text('No data available'),
// //             ),
// //           );
// //         }
// //
// //         final Map<String, dynamic> userData = storeProfileDocs[0];
// //
// //         return Scaffold(
// //             appBar: AppBar(
// //         title: const Text('Profile'),
// //       ),
// //       drawer: const AppDrawer(),
// //           body: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   ListTile(
// //                     leading: Icon(Icons.email_outlined),
// //                     title: Text('Email'),
// //                     subtitle: Text(userData['email']),
// //                   ),
// //                   Divider(color: Colors.grey.withOpacity(0.8)),
// //                   ProfileListTile(
// //                     title: 'Name',
// //                     trailing: Text(userData['name']),
// //                   ),
// //                    ProfileListTile(
// //                     title: 'Age',
// //                     trailing: Text('${userData['age']}  Years'),
// //                   ),
// //                   ProfileListTile(
// //                     title: 'Weight',
// //                     trailing: Text('${userData['weight']}  pounds'),
// //                   ),
// //                   ProfileListTile(
// //                     title: 'Height',
// //                     trailing: Text('${userData['height']}  cm'),
// //                   ),
// //                   ProfileListTile(
// //                     title: 'Gender',
// //                     trailing: Text(userData['gender']),
// //                   ),
// //
// //
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
//
//
//
// import 'package:firebase_project/res/component/list_tile1.dart';
// import 'package:firebase_project/res/component/custom_button.dart';
// import 'package:firebase_project/view_model/profile/profile_controller.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class ProfileDetailsScreen extends StatefulWidget {
//   @override
//   _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
// }
//
// class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
//
//
//   final _formKey = GlobalKey<FormState>();
//   bool loading = false;
//   bool _obscureText = true;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height * 1;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: const Color(0xff3140b0),
//         automaticallyImplyLeading: false,
//         title: const Center(child: Text('CoachBot')),
//       ),
//       body: SafeArea(
//           child: Padding(padding: EdgeInsets.all(4),
//               child: ChangeNotifierProvider(create: (_) => ProfileController(),
//                 child: Consumer<ProfileController>(
//                   builder: (context , provider, child){
//                     return SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 25, right: 25),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                         ListTile(
//                     leading: Icon(Icons.email_outlined),
//                     title: Text('Email'),
//                     subtitle: Text(ProfileController().userData['email']),
//                   ),
//                   Divider(color: Colors.grey.withOpacity(0.8)),
//                   ListTile1(
//                     title: 'Name',
//                     trailing: Text(ProfileController().userData['name']),
//                   ),
//                    ListTile1(
//                     title: 'Age',
//                     trailing: Text('${ProfileController().userData['age']}  Years'),
//                   ),
//                   ListTile1(
//                     title: 'Weight',
//                     trailing: Text('${ProfileController().userData['weight']}  pounds'),
//                   ),
//                   ListTile1(
//                     title: 'Height',
//                     trailing: Text('${ProfileController().userData['height']}  cm'),
//                   ),
//                   ListTile1(
//                     title: 'Gender',
//                     trailing: Text(ProfileController().userData['gender']),
//                   ),
//
//                             RoundButton(
//                               title: 'Next',
//                               loading: provider.loading,
//                               onTap: () {
//                                 if (_formKey.currentState!.validate()) {
//                                 provider.fetchUserData();
//                                   //signUp();
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                     //);
//                   } ,
//                 ),
//
//               )
//           )
//       ),
//     );
//   }
// }
