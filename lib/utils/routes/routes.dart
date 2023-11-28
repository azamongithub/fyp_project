import 'package:CoachBot/res/component/bottom_nav_bar.dart';
import 'package:CoachBot/utils/routes/route_name.dart';
import 'package:CoachBot/view/bottom_nav_tabs/ai_trainer_tab.dart';
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
import '../../view/account_details/profile_details_tabs/profile_details_screen.dart';
import '../../view/all_meal_plans/meal_plan_days_screen.dart';
import '../../view/all_meal_plans/meal_plan_details_screen.dart';
import '../../view/nutrition_facts/find_nutrition_facts_screen.dart';
import '../../view/workout/find_workout_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings routs) {
    //final arguments = routs.arguments;
    switch (routs.name) {

      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case RouteName.signupForm:
        return CupertinoPageRoute(builder: (_) => const SignupForm());
      case RouteName.loginForm:
        return CupertinoPageRoute(builder: (_) => const LoginForm());

      case RouteName.forgotPasswordScreen:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.changePasswordScreen:
        return CupertinoPageRoute(builder: (_) => ChangePasswordScreen());
      // case RouteName.AccountDetailsScreen:
      //   return CupertinoPageRoute(builder: (_) => const AccountDetailsScreen());



      case RouteName.bottomNavBar:
        return CupertinoPageRoute(builder: (_) => const BottomNavBar());

      case RouteName.myPlanTab:
        return CupertinoPageRoute(builder: (_) => Dashboard());
      case RouteName.workoutTab:
        return CupertinoPageRoute(builder: (_) => PlansTab());
      case RouteName.statsTab:
        return CupertinoPageRoute(builder: (_) => const StatsTab());
      case RouteName.aiTrainerTab:
        return CupertinoPageRoute(builder: (_) => AiTrainerTab());
      case RouteName.settingsTab:
        return CupertinoPageRoute(builder: (_) => const SettingsTab());

      case RouteName.profileForm:
        return CupertinoPageRoute(builder: (_) => const ProfileForm());
      case RouteName.fitnessAnalyzerForm:
        return CupertinoPageRoute(builder: (_) => const FitnessAnalyzerForm());
      case RouteName.healthStatusForm:
        return CupertinoPageRoute(builder: (_) => const HealthStatusForm());


      case RouteName.profileDetailsScreen:
        return CupertinoPageRoute(builder: (_) => const ProfileDetailsScreen());

      case RouteName.mealPlanDetailsScreen:
        final argsItem = routs.arguments as Map<String, dynamic>;
        final String day = argsItem['day'];
        final Map<String, dynamic> dayDetails = argsItem['dayDetails'];
        return CupertinoPageRoute(
          builder: (_) => MealPlanDetailsScreen(
            day: day,
            dayDetails: dayDetails,
          ),
        );

      case RouteName.mealPlanDaysScreen:
        final argsItem = routs.arguments as Map<String, dynamic>;
        final String name = argsItem['name'];
        return CupertinoPageRoute(
          builder: (_) => MealPlanDaysScreen(
            name: name,
          ),
        );

      case RouteName.findWorkoutsScreen:
        return CupertinoPageRoute(builder: (_) => FindWorkoutsScreen());

        case RouteName.findNutritionFactsScreen:
        return CupertinoPageRoute(builder: (_) => FindNutritionFactsScreen());
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
