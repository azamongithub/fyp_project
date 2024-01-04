import 'package:CoachBot/modules/search_workout/view/workouts_list_screen.dart';
import 'package:flutter/cupertino.dart';
import '../common_components/bottom_nav_bar.dart';
import '../models/workout_plan_model.dart';
import '../modules/fitness/view/fitness_analyzer_form/fitness_analyzer_form.dart';
import '../modules/health_status/view/select_health_status/health_status_screen.dart';
import '../modules/meal_plan/view/meal_plan_days_screen/meal_plan_days_screen.dart';
import '../modules/meal_plan/view/meal_plan_details_screen/meal_plan_details_screen.dart';
import '../modules/nutrition_facts/view/find_nutrition_facts_screen.dart';
import '../modules/profile/view/profile_details/profile_details_screen.dart';
import '../modules/dashboard/view/dashboard_screen.dart';
import '../modules/my_plans/view/plans_tab.dart';
import '../modules/select_fitness_goal/view/fitness_goal._screen.dart';
import '../modules/settings/view/settings_screen.dart';
import '../modules/change_password/view/change_password_screen.dart';
import '../modules/forgot_password/view/forgot_password_screen.dart';
import '../modules/login/view/login_screen.dart';
import '../modules/profile/view/profile_form/profile_form.dart';
import '../modules/send_feedback_screen/view/send_feedback_screen.dart';
import '../modules/signup/view/signup_screen.dart';
import '../modules/splash/view/splash_screen.dart';
import '../modules/workout_plan/view/workout_plan_days_screen.dart';
import '../modules/workout_plan/view/workout_plan_details_screen.dart';
import 'route_name.dart';

class Routes {
  Route? onGenerateRoute(settings) {
    switch (settings.name) {
      case RouteName.splashScreen:
        return CupertinoPageRoute(builder: (_) => const SplashScreen());
      case RouteName.signupForm:
        return CupertinoPageRoute(builder: (_) => const SignupForm());
      case RouteName.loginForm:
        return CupertinoPageRoute(builder: (_) => const LoginForm());

      case RouteName.forgotPasswordScreen:
        return CupertinoPageRoute(builder: (_) => const ForgotPasswordScreen());
      case RouteName.changePasswordScreen:
        return CupertinoPageRoute(builder: (_) => const ChangePasswordScreen());
      // case RouteName.AccountDetailsScreen:
      //   return CupertinoPageRoute(builder: (_) => const AccountDetailsScreen());

      case RouteName.bottomNavBar:
        return CupertinoPageRoute(builder: (_) => const BottomNavBar());

      case RouteName.myPlanTab:
        return CupertinoPageRoute(builder: (_) => const DashboardScreen());
      case RouteName.workoutTab:
        return CupertinoPageRoute(builder: (_) => PlansTab());
      case RouteName.settingsTab:
        return CupertinoPageRoute(builder: (_) => const SettingsTab());

      case RouteName.profileForm:
        return CupertinoPageRoute(builder: (_) => const ProfileForm());

      // case RouteName.fitnessAnalyzerForm:
      //   final argsItem = settings.arguments as Map<String, dynamic>;
      //   final bool isEdit = argsItem['isEdit'] ?? false;
      //   return CupertinoPageRoute(
      //     builder: (_) => FitnessAnalyzerForm(
      //       isEdit: isEdit,
      //     ),
      //   );
      //
      // case RouteName.fitnessGoalForm:
      //   return CupertinoPageRoute(
      //     builder: (context) {
      //       //final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      //       final argsItem = settings.arguments as Map<String, dynamic>;
      //       final bool isEdit = argsItem['isEdit'] ?? false;
      //       return FitnessGoalForm(isEdit: isEdit);
      //     },
      //   );

      case RouteName.fitnessAnalyzerForm:
        return CupertinoPageRoute(builder: (_) => const FitnessAnalyzerForm());

      case RouteName.fitnessGoalForm:
        return CupertinoPageRoute(builder: (_) => const FitnessGoalForm());

      case RouteName.healthStatusForm:
        return CupertinoPageRoute(builder: (_) => const HealthStatusForm());

      case RouteName.profileDetailsScreen:
        return CupertinoPageRoute(builder: (_) => const ProfileDetailsScreen());

      case RouteName.sendFeedbackScreen:
        return CupertinoPageRoute(builder: (_) => const SendFeedbackScreen());

      case RouteName.mealPlanDetailsScreen:
        final argsItem = settings.arguments as Map<String, dynamic>;
        final String day = argsItem['day'];
        final Map<String, dynamic> dayDetails = argsItem['dayDetails'];
        return CupertinoPageRoute(
          builder: (_) => MealPlanDetailsScreen(
            day: day,
            dayDetails: dayDetails,
          ),
        );

      case RouteName.mealPlanDaysScreen:
        final argsItem = settings.arguments as Map<String, dynamic>;
        final String name = argsItem['name'];
        //final int calories = argsItem['calories'];
        return CupertinoPageRoute(
          builder: (_) => MealPlanDaysScreen(
            name: name,
            // totalCalories: calories,
          ),
        );

      case RouteName.workoutPlanDetailsScreen:
        final argsItem = settings.arguments as Map<String, dynamic>;
        final String day = argsItem['day'];
        final WorkoutDay dayDetails = argsItem['dayDetails'];
        return CupertinoPageRoute(
          builder: (_) => WorkoutPlanDetailsScreen(
            day: day,
            dayDetails: dayDetails,
          ),
        );

      case RouteName.workoutPlanDaysScreen:
        final argsItem = settings.arguments as Map<String, dynamic>;
        final String name = argsItem['name'];
        return CupertinoPageRoute(
          builder: (_) => WorkoutPlanDaysScreen(
            name: name,
          ),
        );

      case RouteName.workoutListScreen:
        return CupertinoPageRoute(builder: (_) => WorkoutListScreen());

      case RouteName.findNutritionFactsScreen:
        return CupertinoPageRoute(builder: (_) => FindNutritionFactsScreen());

      default:
        return CupertinoPageRoute(builder: (_) => const LoginForm());
    }
  }
}
