import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/utils/routes/routes.dart';
import 'package:CoachBot/view/fitness_analyzer_form/fitness_form_controller.dart';
import 'package:CoachBot/view/health_status_form/health_status_provider.dart';
import 'package:CoachBot/view/profile_form/profile_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'constants/app_string_constants.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //   designSize: const Size(375, 812),
    //   minTextAdapt: true,
    //   splitScreenMode: true,
    //   useInheritedMediaQuery: true,
    //   builder: (BuildContext context, Widget? child) {
    //     return SafeArea(
    //       child: MaterialApp(
    //         debugShowCheckedModeBanner: false,
    //         title: AppStrings.title,
    //         // theme: ThemeData(
    //         //   primarySwatch: Colors.indigo,
    //         // ),
    //
    //         theme: ThemeData(
    //           primarySwatch: Colors.indigo,
    //           textTheme: const TextTheme(
    //             bodyMedium: TextStyle(
    //               fontFamily: 'Poppins',
    //             ),
    //           ),
    //         ),
    //
    //         initialRoute: RouteName.SplashScreen,
    //         onGenerateRoute: Routes.generateRoute,
    //       ),
    //     );
    //   },
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileFormController()),
        ChangeNotifierProvider(create: (_) => FitnessFormController()),
        ChangeNotifierProvider(create: (_) => HealthFormController()),
      ],
      child: Builder(builder: (context) {
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          useInheritedMediaQuery: true,
          builder: (BuildContext context, Widget? child) {
            return SafeArea(
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                        theme: ThemeData(
                          primarySwatch: Colors.indigo,
                          textTheme: const TextTheme(
                            bodyMedium: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                        initialRoute: RouteName.splashScreen,
                        onGenerateRoute: Routes.generateRoute,
              ),
            );
          },
        );
      }),
    );
  }
}
