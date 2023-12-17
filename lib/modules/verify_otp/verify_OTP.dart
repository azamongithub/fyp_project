// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import '../../res/component/custom_button.dart';
// import '../../utils/utils.dart';
//
//
// class VerifyOtpScreen extends StatefulWidget {
//   final String verificationId;
//
//   const VerifyOtpScreen({Key? key , required this.verificationId}) : super(key: key);
//
//   @override
//   State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
// }
//
// class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
//
//   bool loading = false;
//   final verifyCodeController = TextEditingController();
//   final auth = FirebaseAuth.instance;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Verify'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 28),
//         child: Column(
//           children: [
//             const SizedBox(height: 50,),
//
//             TextFormField(
//               controller: verifyCodeController,
//               keyboardType: TextInputType.number,
//               decoration: const InputDecoration(
//                 labelText: 'Enter 6 Digit Code',
//               ),
//             ),
//             const SizedBox(height: 30,),
//
//             RoundButton(title: 'Verify', loading: loading, onTap: ()async{
//
//               setState(() {
//                 loading = true;
//               });
//
//               final credential = PhoneAuthProvider.credential(
//                   verificationId: widget.verificationId,
//                   smsCode: verifyCodeController.text.toString(),
//               );
//
//               try{
//                 await auth.signInWithCredential(credential);
//                 // Navigator.push(context,
//                 //     MaterialPageRoute(builder: (context)=> const PostScreen()));
//               }catch(e){
//                 setState(() {
//                   loading = false;
//                 });
//                 Utils.toastMessage(e.toString());
//
//               }
//
//
//             }),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
