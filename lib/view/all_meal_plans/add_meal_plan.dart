import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/meal_plan_model.dart';

class AddMealPlanToFirestore {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addMealPlan(MealPlanModel mealPlan) async {
    await _firestore.collection('meal_plans').doc(mealPlan.id).set(mealPlan.toJson());
  }

}