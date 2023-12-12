import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../../../models/all_plan_model.dart';
import '../../../models/meal_plan_model.dart';
import '../../../services/api_repository.dart';
import '../../../services/firestore_service.dart';

class DashboardController extends ChangeNotifier {
  final ApiRepository _apiRepository = ApiRepository();
  late PredictionModel _apiData;
  PredictionModel get apiData => _apiData;
  final FirestoreService _firestoreService = FirestoreService();
  Map<String, dynamic> _responseData = {};
  Map<String, dynamic> get responseData => _responseData;



  Future<void> fetchData() async {
    // await Future.delayed(Duration(seconds: 3));
    final user = FirebaseAuth.instance.currentUser;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .get();

    if (snapshot.exists) {
      final userData = snapshot.data() as Map<String, dynamic>?;
      if (userData != null) {
        fetchDataAndStore({
          "Age": userData['age'],
          "Gender": userData['gender'],
          "Height": userData['heightInFeet'],
          "Weight": userData['weight'],
          "Fitness_Level": userData['fitnessLevel'],
          "Fitness_Goal": userData['fitnessGoal'],
          "Medical_History": userData['disease'],
        });
      }
    } else {
      print('Document does not exist');
    }
  }

  Future<void> fetchDataAndStore(Map<String, dynamic> requestData) async {
    try {
      _responseData = await _apiRepository.fetchData(requestData);
      await _firestoreService.storeUserData(_responseData);
      notifyListeners(); // Notify listeners about the change in state
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> addMealPlan(MealPlanModel mealPlan) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('meal_plans')
        .doc(mealPlan.id)
        .set(mealPlan.toJson());
  }

  MealPlanModel mealPlan = MealPlanModel(
    id: 'heartwise-trim-thrive',
    name: 'Heartwise Trim & Thrive',
    //totalCalories: 2000,
    disease: 'Hypercholesterolaemia',
    description:
        'Heart-healthy, low in saturated/trans fats; omega-3-rich foods; high-fiber fruits, veggies, and whole grains.',
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
          title4:
              '1 cup mixed vegetables (e.g., broccoli, bell peppers, carrots)',
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
          title2:
              '1 cup mixed vegetable sticks (e.g., carrots, cucumber, bell peppers)',
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



  // Future<void> mergeUserDataByType() async {
  //   try {
  //     final user = FirebaseAuth.instance.currentUser;
  //
  //     final profileData = await FirebaseFirestore.instance
  //         .collection('UserProfileCollection')
  //         .doc(user!.uid)
  //         .get();
  //
  //     final fitnessData = await FirebaseFirestore.instance
  //         .collection('UserFitnessCollection')
  //         .doc(user.uid)
  //         .get();
  //
  //     final healthData = await FirebaseFirestore.instance
  //         .collection('UserHealthCollection')
  //         .doc(user.uid)
  //         .get();
  //
  //     final mergedData = {
  //       'profile': profileData.data(),
  //       'fitness': fitnessData.data(),
  //       'health': healthData.data(),
  //     };
  //
  //     await FirebaseFirestore.instance
  //         .collection('UserCollection')
  //         .doc(user.uid)
  //         .set(mergedData);
  //     print('UserCollection Merge successful!');
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }
}
