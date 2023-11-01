import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'appWidget.dart';
import 'utils/routes/route_name.dart';
import 'utils/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => const MyApp(),
  ),);
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async{
  await Firebase.initializeApp();
  if (kDebugMode) {
    print(message.notification!.title.toString());
  }
}

// class MyApp extends StatelessWidget {
//   MyApp({super.key});
//
//   // This widget is the root of your application.
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//     future: _initialization,
//     builder: (context, snapshot){
//       if(snapshot.hasError){
//         print("Something is Wrong");
//       }
//       if(snapshot.connectionState == ConnectionState.done) {
//         print("Every thing is right");
//         return MaterialApp(
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             primarySwatch: Colors.indigo,
//           ),
//           debugShowCheckedModeBanner: false,
//           initialRoute: RouteName.SplashScreen,
//           onGenerateRoute: Routes.generateRoute,
//         );
//       }
//       return CircularProgressIndicator();
//     },);
//   }
// }


// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(DevicePreview(
//     enabled: false,
//     builder: (context) => const MyApp(),
//   ),
//   );
// }

