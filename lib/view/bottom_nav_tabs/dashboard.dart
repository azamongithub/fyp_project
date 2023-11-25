import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/notifications_services/notifications_services.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/meal_plan_model.dart';
import '../../utils/routes/route_name.dart';
import '../nutrition_facts/find_nutrition_facts_screen.dart';
import '../workout/find_workout_screen.dart';

class Dashboard extends StatefulWidget {
  Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.getDeviceToken().then((value) {
      notificationServices.firebaseInit(context);
      notificationServices.setupInteractMessage(context);
      if (kDebugMode) {
        print('device token');
      }
      if (kDebugMode) {
        print(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

    Future<void> addMealPlan(MealPlanModel mealPlan) async {
      await _firestore
          .collection('meal_plans')
          .doc(mealPlan.id)
          .set(mealPlan.toJson());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.dashboard,
          style: MyTextStyle.appBarStyle(),
        ),
        automaticallyImplyLeading: false,
        actions: [
          ElevatedButton.icon(
              onPressed: () async {
                MealPlanModel mealPlan = MealPlanModel(
                  id: 'carb-controlled-harmony-diabetes',
                  name: 'Carb-Controlled Harmony',
                  disease: 'Diabetes',
                  description: 'Balanced with controlled carbs; include whole grains, lean proteins, healthy fats, and veggies.',
                  days: {
                    'Monday': Day(
                      breakfast: Meal(
                        title1: 'Greek Yogurt Parfait',
                        title2: '1 cup plain Greek yogurt',
                        title3: '1/2 cup mixed berries',
                        title4: '1/4 cup granola (whole grain)',
                        title5: '1 tablespoon chia seeds',
                      ),
                      morningSnack: Meal(
                        title1: 'Handful of Almonds',
                        title2: '1 medium apple',
                      ),
                      lunch: Meal(
                        title1: 'Grilled Chicken Salad',
                        title2: '4 oz. grilled chicken breast',
                        title3: '2 cups mixed greens',
                        title4: '1/2 cup cherry tomatoes',
                        title5: '1/4 cup cucumber slices',
                        title6: '1/4 cup quinoa (whole grain)',
                        title7: '1 tablespoon olive oil dressing',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Carrot Sticks with Hummus',
                        title2: '1/2 cup hummus',
                      ),
                      dinner: Meal(
                        title1: 'Baked Cod with Sweet Potato and Broccoli',
                        title2: '6 oz. baked cod fillet',
                        title3: '1 medium sweet potato, baked',
                        title4: '1 cup steamed broccoli',
                        title5: '1 tablespoon olive oil drizzle',
                      ),
                    ).toJson(),
                    'Tuesday': Day(
                      breakfast: Meal(
                        title1: 'Oatmeal with Berries and Nuts',
                        title2: '1/2 cup rolled oats (whole grain)',
                        title3: '1 cup almond milk',
                        title4: '1/2 cup mixed berries',
                        title5: '1 tablespoon chopped nuts',
                        title6: '1 teaspoon honey',
                      ),
                      morningSnack: Meal(
                        title1: 'Banana with Almond Butter',
                        title2: '1 medium banana',
                        title3: '2 tablespoons almond butter',
                      ),
                      lunch: Meal(
                        title1: 'Quinoa and Black Bean Bowl',
                        title2: '1 cup cooked quinoa (whole grain)',
                        title3: '1/2 cup black beans',
                        title4: '1/2 cup corn kernels',
                        title5: '1/4 cup diced avocado',
                        title6: '1 tablespoon lime juice',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Greek Yogurt with Pineapple',
                        title2: '1 cup plain Greek yogurt',
                        title3: '1/2 cup fresh pineapple chunks',
                      ),
                      dinner: Meal(
                        title1: 'Vegetarian Stir-Fry',
                        title2: '1 cup tofu cubes',
                        title3: '1 cup broccoli florets',
                        title4: '1/2 cup sliced bell peppers',
                        title5: '1/4 cup sliced carrots',
                        title6: '2 tablespoons soy sauce',
                        title7: '1 tablespoon sesame oil',
                      ),
                    ).toJson(),
                    'Wednesday': Day(
                      breakfast: Meal(
                        title1: 'Whole Grain Pancakes with Berries',
                        title2: '2 whole grain pancakes',
                        title3: '1/2 cup mixed berries',
                        title4: '1 tablespoon maple syrup',
                      ),
                      morningSnack: Meal(
                        title1: 'Handful of Walnuts',
                        title2: '1 medium orange',
                      ),
                      lunch: Meal(
                        title1: 'Turkey and Veggie Wrap',
                        title2: '4 oz. sliced turkey breast',
                        title3: '1 whole grain wrap',
                        title4: '1/4 cup hummus',
                        title5: '1/2 cup mixed greens',
                        title6: '1/4 cup shredded carrots',
                        title7: '1/4 cup sliced cucumber',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Yogurt with Mixed Nuts',
                        title2: '1 cup low-fat yogurt',
                        title3: '1/4 cup mixed nuts',
                      ),
                      dinner: Meal(
                        title1: 'Grilled Salmon with Quinoa and Asparagus',
                        title2: '6 oz. grilled salmon fillet',
                        title3: '1 cup cooked quinoa (whole grain)',
                        title4: '1 cup steamed asparagus',
                        title5: '1 tablespoon olive oil drizzle',
                      ),
                    ).toJson(),
                    'Thursday': Day(
                      breakfast: Meal(
                        title1: 'Spinach and Feta Omelette',
                        title2: '3 large eggs, beaten',
                        title3: '1 cup fresh spinach',
                        title4: '2 tablespoons feta cheese',
                        title5: '1/2 cup cherry tomatoes, sliced',
                        title6: '1 teaspoon olive oil',
                      ),
                      morningSnack: Meal(
                        title1: 'Mixed Berries Smoothie',
                        title2: '1/2 cup mixed berries',
                        title3: '1/2 banana',
                        title4: '1/2 cup low-fat yogurt',
                        title5: '1/2 cup almond milk',
                      ),
                      lunch: Meal(
                        title1: 'Quinoa Salad with Chickpeas',
                        title2: '1 cup cooked quinoa (whole grain)',
                        title3: '1/2 cup canned chickpeas, rinsed',
                        title4: '1/4 cup diced red onion',
                        title5: '1/4 cup diced cucumber',
                        title6: '1/4 cup cherry tomatoes, halved',
                        title7: '1/4 cup crumbled feta cheese',
                        title8: '1 tablespoon olive oil dressing',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Carrot and Celery Sticks with Hummus',
                        title2: '1 cup carrot and celery sticks',
                        title3: '1/4 cup hummus',
                      ),
                      dinner: Meal(
                        title1: 'Chicken and Vegetable Stir-Fry',
                        title2: '4 oz. chicken breast, sliced',
                        title3: '1 cup broccoli florets',
                        title4: '1/2 cup snap peas',
                        title5: '1/2 cup bell peppers, sliced',
                        title6: '1 tablespoon soy sauce',
                        title7: '1 tablespoon sesame oil',
                        title8: '1/2 cup cooked brown rice',
                      ),
                    ).toJson(),
                    'Friday': Day(
                      breakfast: Meal(
                        title1: 'Whole Wheat Toast with Smashed Avocado',
                        title2: '2 slices whole wheat toast',
                        title3: '1/2 medium avocado, smashed',
                        title4: '1 poached egg on top',
                        title5: 'Salt and pepper to taste',
                      ),
                      morningSnack: Meal(
                        title1: 'Mixed Fruit Salad',
                        title2: '1 cup mixed fruits (e.g., pineapple, mango, kiwi)',
                        title3: 'Handful of grapes',
                      ),
                      lunch: Meal(
                        title1: 'Shrimp and Quinoa Bowl',
                        title2: '6 oz. grilled shrimp',
                        title3: '1 cup cooked quinoa (whole grain)',
                        title4: '1/2 cup black beans, drained and rinsed',
                        title5: '1/4 cup corn kernels',
                        title6: '1/4 cup diced tomatoes',
                        title7: '1 tablespoon lime juice',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Cottage Cheese with Pineapple',
                        title2: '1 cup low-fat cottage cheese',
                        title3: '1/2 cup fresh pineapple chunks',
                      ),
                      dinner: Meal(
                        title1: 'Vegetarian Quinoa Stir-Fry',
                        title2: '1 cup cooked quinoa (whole grain)',
                        title3: '1/2 cup tofu cubes',
                        title4: '1 cup mixed vegetables (e.g., broccoli, bell peppers, carrots)',
                        title5: '2 tablespoons soy sauce',
                        title6: '1 tablespoon olive oil',
                      ),
                    ).toJson(),
                    'Saturday': Day(
                      breakfast: Meal(
                        title1: 'Smoothie Bowl with Granola',
                        title2: '1 cup mixed berries (frozen or fresh)',
                        title3: '1/2 banana',
                        title4: '1/2 cup low-fat yogurt',
                        title5: '1/4 cup granola (whole grain)',
                        title6: '1 tablespoon honey',
                      ),
                      morningSnack: Meal(
                        title1: 'Handful of Almonds',
                        title2: '1 medium pear',
                      ),
                      lunch: Meal(
                        title1: 'Turkey and Avocado Wrap',
                        title2: '4 oz. sliced turkey breast',
                        title3: '1 whole grain wrap',
                        title4: '1/4 cup mashed avocado',
                        title5: '1/2 cup lettuce',
                        title6: '1/4 cup shredded carrots',
                        title7: '1 tablespoon Greek yogurt dressing',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Vegetable Sticks with Hummus',
                        title2: '1 cup mixed vegetable sticks (e.g., carrots, cucumber, bell peppers)',
                        title3: '1/4 cup hummus',
                      ),
                      dinner: Meal(
                        title1: 'Salmon Salad with Quinoa',
                        title2: '6 oz. grilled salmon fillet',
                        title3: '2 cups mixed greens',
                        title4: '1/2 cup cooked quinoa (whole grain)',
                        title5: '1/4 cup cherry tomatoes, halved',
                        title6: '1/4 cup cucumber slices',
                        title7: '1 tablespoon balsamic vinaigrette',
                      ),
                    ).toJson(),
                    'Sunday': Day(
                      breakfast: Meal(
                        title1: 'Vegetable Omelette with Whole Wheat Toast',
                        title2: '3 large eggs, beaten',
                        title3: '1/2 cup mixed bell peppers, diced',
                        title4: '1/4 cup red onion, diced',
                        title5: '1/4 cup feta cheese, crumbled',
                        title6: '2 slices whole wheat toast',
                      ),
                      morningSnack: Meal(
                        title1: 'Mixed Nuts and Dried Fruits',
                        title2: '1/4 cup mixed nuts (almonds, walnuts)',
                        title3: '1/4 cup dried fruits (apricots, cranberries)',
                      ),
                      lunch: Meal(
                        title1: 'Chicken and Quinoa Salad',
                        title2: '4 oz. grilled chicken breast, sliced',
                        title3: '1 cup cooked quinoa (whole grain)',
                        title4: '2 cups mixed salad greens',
                        title5: '1/2 cup cherry tomatoes, halved',
                        title6: '1/4 cup sliced cucumber',
                        title7: '1 tablespoon olive oil dressing',
                      ),
                      afternoonSnack: Meal(
                        title1: 'Greek Yogurt with Berries',
                        title2: '1 cup plain Greek yogurt',
                        title3: '1/2 cup mixed berries',
                      ),
                      dinner: Meal(
                        title1: 'Vegetarian Stir-Fry with Brown Rice',
                        title2: '1 cup tofu cubes',
                        title3: '1 cup broccoli florets',
                        title4: '1/2 cup snap peas',
                        title5: '1/2 cup carrots, sliced',
                        title6: '2 tablespoons soy sauce',
                        title7: '1 tablespoon sesame oil',
                        title8: '1/2 cup cooked brown rice',
                      ),
                    ).toJson(),
                  },
                );
                addMealPlan(mealPlan);
              },
              icon: const Icon(Icons.add),
              label: const Text('Add'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  'Welcome to CoachBot Fitness App',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.058,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fitness Goals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text('Progress towards your fitness goals'),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('75% Completed'),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => ExerciseListScreen()),
                          //     );
                          //   },
                          //   child: const Text('View Exercises'),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        AppStrings.recommendedWorkouts,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Discover workouts tailored to your goals'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.FindWorkoutsScreen);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => FindWorkoutsScreen()),
                          // );
                        },
                        child: const Text('View Workouts'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nutrition',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Find nutrition facts of any Item'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.FindNutritionFactsScreen);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           FindNutritionFactsScreen()),
                          // );
                        },
                        child: const Text('Nutrition Facts'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:firebase_project/res/component/drawer.dart';
// import 'package:flutter/material.dart';
//
// class MyPlanTab extends StatefulWidget {
//   static const String id = 'home_screen';
//   static const String id2 = 'schedule';
//   const MyPlanTab({Key? key}) : super(key: key);
//
//   @override
//   State<MyPlanTab> createState() => _MyPlanTabState();
// }
//
// class _MyPlanTabState extends State<MyPlanTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        title: const Text('Home'),
//       ),
//       drawer: const AppDrawer(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         //crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//
//           const Center(
//             child: Text('This is a Home Screen'),
//           ),
//
//           Center(
//             child: TextButton(
//               onPressed: (){
//                 Navigator.pushNamed(context,MyPlanTab.id2);
//               },
//               child: const Text('Go to Schedule'),
//
//             ),
//
//           )
//         ],
//       ),
//
//     );
//   }
// }
