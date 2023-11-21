import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/meal_plan_model.dart';
import 'meal_plan_details_screen.dart';

class MealPlanDaysScreen extends StatelessWidget {
  late double cal;
  final int totalCalories;
  final String type;
  final String disease;
  final String? mealPlanId;

  MealPlanDaysScreen({
    super.key,
    required this.totalCalories,
    required this.type,
    required this.disease,
    this.mealPlanId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Plan '),
      ),
      body: FutureBuilder<List<MealPlanModel>>(
        future: fetchMealPlansByCalories(totalCalories, type, disease),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Data Found'),
            );
          }
          List<MealPlanModel> mealPlans = snapshot.data!;
          Map<String, int> weekdaysMap = {
            'Monday': DateTime.monday,
            'Tuesday': DateTime.tuesday,
            'Wednesday': DateTime.wednesday,
            'Thursday': DateTime.thursday,
            'Friday': DateTime.friday,
            'Saturday': DateTime.saturday,
            'Sunday': DateTime.sunday,
          };
          List<MapEntry<String, dynamic>> orderedDays = mealPlans.first.days.entries.toList()
            ..sort((a, b) {
              return weekdaysMap[a.key]! - weekdaysMap[b.key]!;
            });
          return ListView(
            children: [
              for (var dayEntry in orderedDays)
                daysCard(
                  day: dayEntry.key,
                  calories: mealPlans.first.totalCalories.toString(),
                  type: mealPlans.first.type.toString(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealPlanDetailsScreen(
                          day: dayEntry.key,
                          dayDetails: dayEntry.value,
                        ),
                      ),
                    );
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}

Widget daysCard({
  required String day,
  String? calories,
  String? type,
  required VoidCallback onPressed,
}) {
  return Card(
    child: SizedBox(
      height: 80,
      child: Center(
        child: ListTile(
          title: Text(day),
          leading: Text(calories!),
          subtitle: Text(type!),
          trailing: const Icon(Icons.arrow_forward),
          onTap: onPressed,
        ),
      ),
    ),
  );
}

Future<List<MealPlanModel>> fetchMealPlansByCalories(
    int totalCalories, String type, String disease) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meal_plans')
        .where('type', isEqualTo: type)
        .where('disease', isEqualTo: disease)
        .get();

    List<MealPlanModel> mealPlans = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return MealPlanModel.fromJson(doc.id, data);
    }).toList();

    if (mealPlans.isNotEmpty) {
      mealPlans
          .sort((a, b) => (a.totalCalories - totalCalories).abs().compareTo(
                (b.totalCalories - totalCalories).abs(),
              ));
      return [mealPlans.first];
    } else {
      return [];
    }
  } catch (e) {
    print('Error fetching meal plans: $e');
    return [];
  }
}
