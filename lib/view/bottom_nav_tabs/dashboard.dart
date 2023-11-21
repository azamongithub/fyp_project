import 'package:CoachBot/notifications_services/notifications_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../models/meal_plan_model.dart';
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
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
        // actions: [
        //   ElevatedButton.icon(
        //       onPressed: () async {
        //         MealPlanModel mealPlan = MealPlanModel(
        //           id: 'low-caloric-none-2600',
        //           type: 'Low Caloric Diet',
        //           disease: 'none',
        //           totalCalories: 2600,
        //           days: {
        //             'Monday': Day(
        //               breakfast: Meal(
        //                 title1: 'Avocado-Egg Toast',
        //                 title2: '1 slice whole-grain bread',
        //                 title3: '1/2 medium avocado',
        //                 title4:
        //                     '1 large egg, cooked in 1/4 tsp. olive oil or coat pan with a thin layer of cooking spray (1-second spray)',
        //                 title5: 'Season egg with a pinch of salt and pepper.',
        //                 title6: '2 clementines',
        //                 mealCalories: '382 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '1 medium apple',
        //                 title2: '2 Tbsp. peanut butter',
        //                 mealCalories: '305 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: '2 cups Ravioli and Vegetable Soup',
        //                 title2:
        //                     '2 diagonal slices baguette (1/4 inch thick), preferably whole-wheat',
        //                 title3:
        //                     '3 Tbsp. shredded Cheddar cheese Top baguette slices with 1 1/2 Tbsp. cheese each and a pinch of pepper. Toast until cheese is melted.',
        //                 title4: 'diced grilled veggies (2 tablespoons onion',
        //                 title5: '1/4 cup diced zucchini, 1/2 cup bell pepper)',
        //                 title6: '1 teaspoon chopped cilantro',
        //                 title7: '1 tablespoon vinaigrette',
        //                 mealCalories: '407 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '4 Tbsp. hummus',
        //                 title2: '1 cup sliced cucumber',
        //                 title3: '2 medium carrots',
        //                 mealCalories: '169 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: 'Salmon and Vegetables',
        //                 title2: '4 oz. baked salmon',
        //                 title3: '1 cup roasted Brussels sprouts',
        //                 title4: '1 cup brown rice',
        //                 title5: '1/8 tsp. salt',
        //                 title6: '1/8 tsp. pepper',
        //                 title7: '1 Tbsp. walnuts',
        //                 title8: 'Vinaigrette',
        //                 title9:
        //                     'Combine 1 1/2 tsp. each olive oil, lemon juice and maple syrup; season with 1/8 tsp. salt.',
        //                 title10:
        //                     'Toss Brussels sprouts in 1/2 tsp. olive oil and bake at 425°F until lightly browned, 15 to 20 minutes. Coat salmon with 1/4 tsp. olive oil or a thin layer of cooking spray (1-second spray) and season with 1/8 tsp. each salt and pepper. Bake at 425°F until opaque in the middle, 4 to 6 minutes. Serve Brussels sprouts, salmon and brown rice drizzled with vinaigrette and topped with walnuts.',
        //                 mealCalories: '560 Calories',
        //               ),
        //             ).toJson(),
        //             'Tuesday': Day(
        //               breakfast: Meal(
        //                 title1: 'Avocado-Egg Toast',
        //                 title2: '1 slice whole-grain bread',
        //                 title3: '1/2 medium avocado',
        //                 title4:
        //                     '1 large egg, cooked in 1/4 tsp. olive oil or coat pan with a thin layer of cooking spray (1-second spray)',
        //                 title5: 'Season egg with a pinch of salt and pepper.',
        //                 title6: '2 clementines',
        //                 mealCalories: '382 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '8 dried apricots',
        //                 title2: '8 walnut halves',
        //                 mealCalories: '172 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: 'Leftover soup',
        //                 title2: '2 cups Ravioli and Vegetable Soup',
        //                 title3:
        //                     '2 diagonal slices baguette (1/4 inch thick), preferably whole-wheat',
        //                 title4:
        //                     '3 Tbsp. shredded Cheddar cheese Top each baguette slice with 1 1/2 Tbsp. cheese and a pinch of pepper. Toast until cheese is melted',
        //                 title5: '1 clementine',
        //                 mealCalories: '441 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '4 Tbsp. hummus',
        //                 title2: '2 medium carrots',
        //                 mealCalories: '154 Calories',
        //               ),
        //               eveningSnack: Meal(
        //                 title1: '2 Medjool dates',
        //                 mealCalories: '133 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: '1 1/2 cups Delicata Squash and Tofu Curry',
        //                 title2: 'Serve curry over 1 cup brown rice',
        //                 mealCalories: '533 Calories',
        //               ),
        //               planAhead: Meal(
        //                 title1:
        //                     'Plan Ahead: Make Maple-Nut Granola for tomorrow. You can also buy granola, to make things easier. Aim for a granola that has around 130 calories (or less) and less than 6 grams of sugar per 1/4 cup.',
        //               ),
        //             ).toJson(),
        //             'Wednesday': Day(
        //               breakfast: Meal(
        //                 title1: '1/2 cup Maple-Nut Granola',
        //                 title2: '1 cup nonfat plain Greek yogurt',
        //                 title3: '1/4 cup blueberries',
        //                 mealCalories: '405 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '3 Tbsp. hummus',
        //                 title2: '2 medium carrots',
        //                 mealCalories: '128 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: 'Apple and Cheddar Pita Pocket',
        //                 title2: '1 whole-wheat pita round (6-1/2-inch)',
        //                 title3: '1 Tbsp. mustard',
        //                 title4: '1/2 medium apple, sliced',
        //                 title5: '1 1/2 oz. Cheddar cheese',
        //                 title6: '1 cup mixed greens',
        //                 title7:
        //                     'Cut pita in half and spread mustard inside. Fill with apple slices and cheese. Toast until the cheese begins to melt. Add greens and serve.',
        //                 title8: '1 clementine',
        //                 mealCalories: '443 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '1/2 medium apple, sliced',
        //                 title2: '1 Tbsp. peanut butter',
        //                 title3: '1/4 cup Maple-Nut Granola',
        //                 title4:
        //                     'Dip apple slices into peanut butter and granola',
        //                 mealCalories: '278 Calories',
        //               ),
        //               eveningSnack: Meal(
        //                 title1:
        //                     '1 Tbsp. chocolate chips, preferably dark chocolate',
        //                 mealCalories: '50 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: '1 Moroccan-Style Stuffed Pepper',
        //                 title2: '2 cups spinach',
        //                 title3:
        //                     'Saute spinach in 1 tsp. olive oil with a pinch of salt and pepper',
        //                 title4: '1 cup sliced carrots, steamed',
        //                 mealCalories: '507 Calories',
        //               ),
        //               planAhead: Meal(
        //                 title1:
        //                     "Plan Ahead: Hard-boil 2 eggs-save one for Day 5. Make Carrot-Ginger Vinaigrette or opt for a healthy, store-bought Asian-style dressing. When buying salad dressing, choose one made with healthy fats, such as olive oil or canola oil. Cook a chicken breast for tomorrow's lunch or substitute precooked chicken or sliced chicken or turkey breast from the grocery store. When choosing deli items, go for low-sodium, preservative-free options.",
        //               ),
        //             ).toJson(),
        //
        //             'Thursday': Day(
        //               breakfast: Meal(
        //                 title1: 'Avocado-Egg Toast',
        //                 title2: '1 slice whole-grain bread',
        //                 title3: '1/2 medium avocado',
        //                 title4:
        //                     '1 large egg, cooked in 1/4 tsp. olive oil or coat pan with a thin layer of cooking spray (1-second spray)',
        //                 title5: 'Season egg with a pinch of salt and pepper.',
        //                 title6: '2 clementines',
        //                 mealCalories: '382 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '1 medium apple',
        //                 title2: '2 Tbsp. peanut butter',
        //                 mealCalories: '305 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: '2 cups Ravioli and Vegetable Soup',
        //                 title2:
        //                     '2 diagonal slices baguette (1/4 inch thick), preferably whole-wheat',
        //                 title3:
        //                     '3 Tbsp. shredded Cheddar cheese Top baguette slices with 1 1/2 Tbsp. cheese each and a pinch of pepper. Toast until cheese is melted.',
        //                 title4: 'diced grilled veggies (2 tablespoons onion',
        //                 title5: '1/4 cup diced zucchini, 1/2 cup bell pepper)',
        //                 title6: '1 teaspoon chopped cilantro',
        //                 title7: '1 tablespoon vinaigrette',
        //                 mealCalories: '407 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '4 Tbsp. hummus',
        //                 title2: '1 cup sliced cucumber',
        //                 title3: '2 medium carrots',
        //                 mealCalories: '169 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: 'Salmon and Vegetables',
        //                 title2: '4 oz. baked salmon',
        //                 title3: '1 cup roasted Brussels sprouts',
        //                 title4: '1 cup brown rice',
        //                 title5: '1/8 tsp. salt',
        //                 title6: '1/8 tsp. pepper',
        //                 title7: '1 Tbsp. walnuts',
        //                 title8: 'Vinaigrette',
        //                 title9:
        //                     'Combine 1 1/2 tsp. each olive oil, lemon juice and maple syrup; season with 1/8 tsp. salt.',
        //                 title10:
        //                     'Toss Brussels sprouts in 1/2 tsp. olive oil and bake at 425°F until lightly browned, 15 to 20 minutes. Coat salmon with 1/4 tsp. olive oil or a thin layer of cooking spray (1-second spray) and season with 1/8 tsp. each salt and pepper. Bake at 425°F until opaque in the middle, 4 to 6 minutes. Serve Brussels sprouts, salmon and brown rice drizzled with vinaigrette and topped with walnuts.',
        //                 mealCalories: '560 Calories',
        //               ),
        //             ).toJson(),
        //             'Friday': Day(
        //               breakfast: Meal(
        //                 title1: 'Avocado-Egg Toast',
        //                 title2: '1 slice whole-grain bread',
        //                 title3: '1/2 medium avocado',
        //                 title4:
        //                     '1 large egg, cooked in 1/4 tsp. olive oil or coat pan with a thin layer of cooking spray (1-second spray)',
        //                 title5: 'Season egg with a pinch of salt and pepper.',
        //                 title6: '2 clementines',
        //                 mealCalories: '382 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '8 dried apricots',
        //                 title2: '8 walnut halves',
        //                 mealCalories: '172 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: 'Leftover soup',
        //                 title2: '2 cups Ravioli and Vegetable Soup',
        //                 title3:
        //                     '2 diagonal slices baguette (1/4 inch thick), preferably whole-wheat',
        //                 title4:
        //                     '3 Tbsp. shredded Cheddar cheese Top each baguette slice with 1 1/2 Tbsp. cheese and a pinch of pepper. Toast until cheese is melted',
        //                 title5: '1 clementine',
        //                 mealCalories: '441 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '4 Tbsp. hummus',
        //                 title2: '2 medium carrots',
        //                 mealCalories: '154 Calories',
        //               ),
        //               eveningSnack: Meal(
        //                 title1: '2 Medjool dates',
        //                 mealCalories: '133 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: '1 1/2 cups Delicata Squash and Tofu Curry',
        //                 title2: 'Serve curry over 1 cup brown rice',
        //                 mealCalories: '533 Calories',
        //               ),
        //               planAhead: Meal(
        //                 title1:
        //                     'Plan Ahead: Make Maple-Nut Granola for tomorrow. You can also buy granola, to make things easier. Aim for a granola that has around 130 calories (or less) and less than 6 grams of sugar per 1/4 cup.',
        //               ),
        //             ).toJson(),
        //             'Saturday': Day(
        //               breakfast: Meal(
        //                 title1: '1/2 cup Maple-Nut Granola',
        //                 title2: '1 cup nonfat plain Greek yogurt',
        //                 title3: '1/4 cup blueberries',
        //                 mealCalories: '405 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '3 Tbsp. hummus',
        //                 title2: '2 medium carrots',
        //                 mealCalories: '128 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: 'Apple and Cheddar Pita Pocket',
        //                 title2: '1 whole-wheat pita round (6-1/2-inch)',
        //                 title3: '1 Tbsp. mustard',
        //                 title4: '1/2 medium apple, sliced',
        //                 title5: '1 1/2 oz. Cheddar cheese',
        //                 title6: '1 cup mixed greens',
        //                 title7:
        //                     'Cut pita in half and spread mustard inside. Fill with apple slices and cheese. Toast until the cheese begins to melt. Add greens and serve.',
        //                 title8: '1 clementine',
        //                 mealCalories: '443 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '1/2 medium apple, sliced',
        //                 title2: '1 Tbsp. peanut butter',
        //                 title3: '1/4 cup Maple-Nut Granola',
        //                 title4:
        //                     'Dip apple slices into peanut butter and granola',
        //                 mealCalories: '278 Calories',
        //               ),
        //               eveningSnack: Meal(
        //                 title1:
        //                     '1 Tbsp. chocolate chips, preferably dark chocolate',
        //                 mealCalories: '50 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: '1 Moroccan-Style Stuffed Pepper',
        //                 title2: '2 cups spinach',
        //                 title3:
        //                     'Saute spinach in 1 tsp. olive oil with a pinch of salt and pepper',
        //                 title4: '1 cup sliced carrots, steamed',
        //                 mealCalories: '507 Calories',
        //               ),
        //               planAhead: Meal(
        //                 title1:
        //                     "Plan Ahead: Hard-boil 2 eggs-save one for Day 5. Make Carrot-Ginger Vinaigrette or opt for a healthy, store-bought Asian-style dressing. When buying salad dressing, choose one made with healthy fats, such as olive oil or canola oil. Cook a chicken breast for tomorrow's lunch or substitute precooked chicken or sliced chicken or turkey breast from the grocery store. When choosing deli items, go for low-sodium, preservative-free options.",
        //               ),
        //             ).toJson(),
        //             'Sunday': Day(
        //               breakfast: Meal(
        //                 title1: 'Avocado-Egg Toast',
        //                 title2: '1 slice whole-grain bread',
        //                 title3: '1/2 medium avocado',
        //                 title4:
        //                     '1 large egg, cooked in 1/4 tsp. olive oil or coat pan with a thin layer of cooking spray (1-second spray)',
        //                 title5: 'Season egg with a pinch of salt and pepper.',
        //                 title6: '2 clementines',
        //                 mealCalories: '382 Calories',
        //               ),
        //               morningSnack: Meal(
        //                 title1: '8 dried apricots',
        //                 title2: '8 walnut halves',
        //                 mealCalories: '172 Calories',
        //               ),
        //               lunch: Meal(
        //                 title1: 'Leftover soup',
        //                 title2: '2 cups Ravioli and Vegetable Soup',
        //                 title3:
        //                     '2 diagonal slices baguette (1/4 inch thick), preferably whole-wheat',
        //                 title4:
        //                     '3 Tbsp. shredded Cheddar cheese Top each baguette slice with 1 1/2 Tbsp. cheese and a pinch of pepper. Toast until cheese is melted',
        //                 title5: '1 clementine',
        //                 mealCalories: '441 Calories',
        //               ),
        //               afternoonSnack: Meal(
        //                 title1: '4 Tbsp. hummus',
        //                 title2: '2 medium carrots',
        //                 mealCalories: '154 Calories',
        //               ),
        //               eveningSnack: Meal(
        //                 title1: '2 Medjool dates',
        //                 mealCalories: '133 Calories',
        //               ),
        //               dinner: Meal(
        //                 title1: '1 1/2 cups Delicata Squash and Tofu Curry',
        //                 title2: 'Serve curry over 1 cup brown rice',
        //                 mealCalories: '533 Calories',
        //               ),
        //               planAhead: Meal(
        //                 title1:
        //                     'Plan Ahead: Make Maple-Nut Granola for tomorrow. You can also buy granola, to make things easier. Aim for a granola that has around 130 calories (or less) and less than 6 grams of sugar per 1/4 cup.',
        //               ),
        //             ).toJson(),
        //             // Repeat for day3, day4, ..., day7
        //           },
        //         );
        //         addMealPlan(mealPlan);
        //       },
        //       icon: const Icon(Icons.add),
        //       label: const Text('Add'))
        // ],
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
                        'Recommended Workouts',
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindWorkoutsScreen()),
                          );
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FindNutritionFactsScreen()),
                          );
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
