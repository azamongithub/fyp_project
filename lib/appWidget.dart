import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/routes/routes.dart';
import 'package:CoachBot/view_model/profile/profile_controller.dart';
import 'package:CoachBot/view_model/profile/profile_form_controller.dart';
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
    //     // ChangeNotifierProvider<ProfileController>(
    //     //     create: (context) => ProfileController()),
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
    //             title: AppStrings.title,
    //                     theme: ThemeData(
    //                       primarySwatch: Colors.indigo,
    //                     ),
    //                     initialRoute: RouteName.SplashScreen,
    //                     onGenerateRoute: Routes.generateRoute,
    //           ),
    //         );
    //       },
    //     );
    //   }),
    // );
  }
}
