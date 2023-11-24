import 'package:CoachBot/res/component/bottom_nav_bar.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/view/account_details/account_details_screen.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/fitness_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/health_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details_screen.dart';
import 'package:CoachBot/view/bottom_nav_tabs/ai_trainer_tab.dart';
import 'package:CoachBot/view/bottom_nav_tabs/meal_tab.dart';
import 'package:CoachBot/view/bottom_nav_tabs/dashboard.dart';
import 'package:CoachBot/view/bottom_nav_tabs/stats_tab.dart';
import 'package:CoachBot/view/bottom_nav_tabs/plans_tab.dart';
import 'package:CoachBot/view/change_password/change_password_screen.dart';
import 'package:CoachBot/view/fitness_analyzer_form/fitness_analyzer_form.dart';
import 'package:CoachBot/view/health_status_form/health_status_form.dart';
import 'package:CoachBot/view/login/login_screen.dart';
import 'package:CoachBot/view/profile_form/profile_form.dart';
import 'package:CoachBot/view/settings/forgot_password/forgot_password_screen.dart';
import 'package:CoachBot/view/bottom_nav_tabs/settings_tab.dart';
import 'package:CoachBot/view/signup/signup_screen.dart';
import 'package:CoachBot/view/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routs) {
    //final arguments = routs.arguments;
    switch (routs.name) {

      case RouteName.SplashScreen:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case RouteName.SignupForm:
        return CupertinoPageRoute(builder: (_) => const SignupForm());
      case RouteName.LoginForm:
        return CupertinoPageRoute(builder: (_) => const LoginForm());

      case RouteName.ForgotPasswordScreen:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.ChangePasswordScreen:
        return CupertinoPageRoute(builder: (_) => const ChangePasswordScreen());
      // case RouteName.AccountDetailsScreen:
      //   return CupertinoPageRoute(builder: (_) => const AccountDetailsScreen());



      case RouteName.BottomNavBar:
        return CupertinoPageRoute(builder: (_) => const BottomNavBar());

      case RouteName.MyPlanTab:
        return CupertinoPageRoute(builder: (_) => Dashboard());
      case RouteName.WorkoutTab:
        return CupertinoPageRoute(builder: (_) => PlansTab());
      case RouteName.MealTab:
        return CupertinoPageRoute(builder: (_) => MealTab());
      case RouteName.StatsTab:
        return CupertinoPageRoute(builder: (_) => const StatsTab());
      case RouteName.AiTrainerTab:
        return CupertinoPageRoute(builder: (_) => AiTrainerTab());
      case RouteName.SettingsTab:
        return CupertinoPageRoute(builder: (_) => const SettingsTab());

      case RouteName.ProfileForm:
        return CupertinoPageRoute(builder: (_) => const ProfileForm());
      case RouteName.FitnessAnalyzerForm:
        return CupertinoPageRoute(builder: (_) => const FitnessAnalyzerForm());
      case RouteName.HealthStatusForm:
        return CupertinoPageRoute(builder: (_) => const HealthStatusForm());


      case RouteName.ProfileDetailsScreen:
        return CupertinoPageRoute(builder: (_) => const ProfileDetailsScreen());
      //   case RouteName.PersonalDetails:
      //   return CupertinoPageRoute(builder: (_) => const PersonalDetails());
      // case RouteName.FitnessDetails:
      //   return CupertinoPageRoute(builder: (_) => const FitnessDetails());
      // case RouteName.HealthDetails:
      //   return CupertinoPageRoute(builder: (_) => const HealthDetails());

      default:
        return CupertinoPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${routs.name}'),
            ),
          );
        });
    }
  }
}
