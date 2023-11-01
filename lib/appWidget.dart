import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/routes/routes.dart';
import 'package:CoachBot/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants/app_string_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return SafeArea(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppStrings.title,
            theme: ThemeData(
              primarySwatch: Colors.indigo,
            ),
            initialRoute: RouteName.SplashScreen,
            onGenerateRoute: Routes.generateRoute,
          ),
        );
      },
    );
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider<AllDataProvider>(
    //         create: (context) => AllDataProvider()),
    //     ChangeNotifierProvider<DriverDataProvider>(
    //         create: (context) => DriverDataProvider(context)),
    //     ChangeNotifierProvider<ConsumerDataProvider>(
    //         create: (context) => ConsumerDataProvider(context)),
    //     ChangeNotifierProvider<FindDriverProvider>(
    //         create: (context) => FindDriverProvider()),
    //     ChangeNotifierProvider<BottomNavBarProvider>(
    //         create: (context) => BottomNavBarProvider()),
    //   ],
    //   child: Builder(builder: (context) {
    //     return ScreenUtilInit(
    //       designSize: const Size(375, 812),
    //       minTextAdapt: true,
    //       splitScreenMode: true,
    //       useInheritedMediaQuery: true,
    //       builder: (BuildContext context, Widget? child) {
    //         return SafeArea(
    //           child: MaterialApp(
    //             debugShowCheckedModeBanner: false,
    //             title: AppConstants.title,
    //             theme: ThemeData(
    //               primarySwatch: Colors.blue,
    //             ),
    //             home: const SplashScreen(),
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  }
}
