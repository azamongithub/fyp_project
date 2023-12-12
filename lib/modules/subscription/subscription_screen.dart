// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class SubscriptionScreen extends StatefulWidget {
//   @override
//   _SubscriptionScreenState createState() => _SubscriptionScreenState();
// }
//
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   bool _isProUser = false; // Initially assume the user is not a pro user
//
//   void _subscribe() {
//     // Implement subscription purchase logic here
//
//     // Once the subscription is successfully purchased, update the user's status
//     setState(() {
//       _isProUser = true;
//     });
//   }
//
//   Map<String,dynamic>? paymentIntentData;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Unlock Premium Features',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             InkWell(
//               onTap: () async{
//                 await makePayment();
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10.0),
//                   color: Colors.blue,
//                 ),
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     const Text(
//                       'Monthly Subscription',
//                       style: TextStyle(
//                         fontSize: 18.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     const Text(
//                       '\$9.99/month',
//                       style: TextStyle(
//                         fontSize: 24.0,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     const SizedBox(height: 10.0),
//                     const Text(
//                       'Unlock unlimited workouts, meal plans, and more!',
//                       style: TextStyle(
//                         fontSize: 14.0,
//                         color: Colors.white,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const SizedBox(height: 20.0),
//                     // RaisedButton(
//                     //   onPressed: _isProUser ? null : _subscribe,
//                     //   color: Colors.white,
//                     //   child: Text(
//                     //     _isProUser ? 'Subscribed' : 'Subscribe',
//                     //     style: TextStyle(
//                     //       fontSize: 18.0,
//                     //       fontWeight: FontWeight.bold,
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20.0),
//             const Text(
//               'Already subscribed? Click here to restore.',
//               style: TextStyle(
//                 fontSize: 14.0,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Future<void> makePayment() async{
//     try{
//       paymentIntentData = await createPaymentIntent('20', 'USD');
//     }catch(e){
//       print('exception' + e.toString());
//     }
//   }
//
//   createPaymentIntent(String amount, String currency){
//     try{
//       Map<String, dynamic> body = {
//         'amount' : calculateAmount(amount),
//         'currency' : currency,
//         'payment_method_types[]': 'card'
//       };
//       //var response = await http.post(Uri.parse('')),
//     }catch(e){
//       print('exception' + e.toString());
//     }
//   }
//   calculateAmount(String amount){
//     final price = int.parse(amount) * 100;
//     return price;
//   }
//
// }
//
// // class WorkoutScreen extends StatelessWidget {
// //   final bool isProUser;
// //
// //   WorkoutScreen({required this.isProUser});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Workouts'),
// //       ),
// //       body: Container(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //             const Text(
// //             'Available Workouts',
// //             style: TextStyle(
// //               fontSize: 24.0,
// //               fontWeight: FontWeight.bold,
// //             ),
// //           ),
// //           const SizedBox(height: 20.0),
// //           if (isProUser)
// //       const Text(
// //       'Premium Workout 1',
// //       style: TextStyle(fontSize: 18.0),
// //     ),
// //     if (isProUser) const SizedBox(height: 10.0),
// //     if (isProUser)
// //     const Text(
// //     'Premium Workout 2',
// //     style: TextStyle(fontSize: 18.0),
// //     ),
// //     const SizedBox(height: 10.0),
// //     const Text(
// //     'Free Workout 1',
// //     style: TextStyle(fontSize: 18),
// //     ),
// //     const Text(
// //     'Free Workout 2',
// //     style: TextStyle(fontSize: 18.0),
// //     ),
// //     ],
// //     ),
// //     ),
// //     );
// //   }
// // }
