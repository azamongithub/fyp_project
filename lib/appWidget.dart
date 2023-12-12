import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'constants/app_string_constants.dart';
import 'modules/dashboard/controller/dashboard_controller.dart';
import 'modules/fitness_analyzer/controller/fitness_form_controller.dart';
import 'modules/health_status/controller/health_status_controller.dart';
import 'modules/profile/controller/profile_form_controller.dart';
import 'modules/select_fitness_goal/controller/fitness_goal_controller.dart';
import 'routes/route_name.dart';
import 'routes/routes.dart';

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
        ChangeNotifierProvider(create: (_) => FitnessGoalController()),
        ChangeNotifierProvider(create: (_) => HealthStatusController()),
        ChangeNotifierProvider(create: (_) => DashboardController()),
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
                          scaffoldBackgroundColor: Colors.white,
                          primarySwatch: Colors.indigo,
                          colorScheme: ColorScheme.fromSeed(seedColor: ColorUtil.themeColor),
                          useMaterial3: true,
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
