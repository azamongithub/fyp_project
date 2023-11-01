import 'package:CoachBot/res/component/bottom_nav_bar.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/view/account_details/account_details_screen.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/fitness_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/health_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details.dart';
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
import 'package:CoachBot/view/settings/settings_screen.dart';
import 'package:CoachBot/view/signup/signup_screen.dart';
import 'package:CoachBot/view/splash/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routs) {
    //final arguments = routs.arguments;
    switch (routs.name) {

      case RouteName.SplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteName.SignupForm:
        return MaterialPageRoute(builder: (_) => SignupForm());
      case RouteName.LoginForm:
        return MaterialPageRoute(builder: (_) => const LoginForm());

      case RouteName.ForgotPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.ChangePasswordScreen:
        return MaterialPageRoute(builder: (_) => ChangePasswordScreen());
      case RouteName.AccountDetailsScreen:
        return MaterialPageRoute(builder: (_) => const AccountDetailsScreen());
      case RouteName.SettingsScreen:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());


      case RouteName.BottomNavBar:
        return MaterialPageRoute(builder: (_) => const BottomNavBar());

      case RouteName.MyPlanTab:
        return MaterialPageRoute(builder: (_) => Dashboard());
      case RouteName.WorkoutTab:
        return MaterialPageRoute(builder: (_) => PlansTab());
      case RouteName.MealTab:
        return MaterialPageRoute(builder: (_) => MealTab());
      case RouteName.StatsTab:
        return MaterialPageRoute(builder: (_) => StatsTab());
      case RouteName.AiTrainerTab:
        return MaterialPageRoute(builder: (_) => AiTrainerTab());

      case RouteName.ProfileForm:
        return MaterialPageRoute(builder: (_) => const ProfileForm());
      case RouteName.FitnessAnalyzerForm:
        return MaterialPageRoute(builder: (_) => const FitnessAnalyzerForm());
      case RouteName.HealthStatusForm:
        return MaterialPageRoute(builder: (_) => const HealthStatusForm());



      case RouteName.PersonalDetails:
        return MaterialPageRoute(builder: (_) => PersonalDetails());
      case RouteName.FitnessDetails:
        return MaterialPageRoute(builder: (_) => const FitnessDetails());
      case RouteName.HealthDetails:
        return MaterialPageRoute(builder: (_) => HealthDetails());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${routs.name}'),
            ),
          );
        });
    }
  }
}
