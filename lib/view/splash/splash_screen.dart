import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import '../../view_model/services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices = SplashServices();
  @override
  void initState() {
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image(
              height: 150,
              width: 150,
              image: AssetImage(ImageConstants.appLogo),
            ),
            Text(
              AppStrings.appName,
              style: TextStyle(fontSize: 30),
            )
          ]),
    ));
  }
}
