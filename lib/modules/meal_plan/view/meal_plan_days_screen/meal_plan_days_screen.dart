import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../models/meal_plan_model.dart';
import '../../../../routes/route_name.dart';
import '../../../../theme/text_style_util.dart';

class MealPlanDaysScreen extends StatelessWidget {
  //late double cal;
  final int? totalCalories;
  final String name;
  final String? disease;
  final String? mealPlanId;

  MealPlanDaysScreen({
    super.key,
    //required this.totalCalories,
    this.totalCalories,
    required this.name,
    this.disease,
    this.mealPlanId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Meal Plan ', style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
      ),
      body: FutureBuilder<List<MealPlanModel>>(
        //future: fetchMealPlansByCalories(name, totalCalories),
        future: fetchMealPlansByCalories(name),
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
          List<MapEntry<String, dynamic>> orderedDays =
              mealPlans.first.days.entries.toList()
                ..sort((a, b) {
                  return weekdaysMap[a.key]! - weekdaysMap[b.key]!;
                });
          return ListView(
            children: [
              for (var dayEntry in orderedDays)
                daysCard(
                  day: dayEntry.key,
                  calories: mealPlans.first.totalCalories.toString(),
                  name: mealPlans.first.name.toString(),
                  onPressed: () {

                    Navigator.pushNamed(
                      context,
                      RouteName.mealPlanDetailsScreen,
                      arguments: {
                        'day': dayEntry.key,
                        'dayDetails': dayEntry.value,
                      },
                    );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MealPlanDetailsScreen(
                    //       day: dayEntry.key,
                    //       dayDetails: dayEntry.value,
                    //     ),
                    //   ),
                    // );
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
  String? name,
  required VoidCallback onPressed,
}) {
  return Card(
    child: SizedBox(
      height: 80,
      child: Center(
        child: ListTile(
          title: Text(
            day,
            style: CustomTextStyle.titleStyle20(),
          ),
          // leading: Text(
          //     calories!,
          //   style: MyTextStyle.subTitleStyle14(),
          // ),
          subtitle: Text(
              name!,
            style: CustomTextStyle.subTitleStyle14(),
          ),
          trailing:  Icon(Icons.arrow_forward, size: 28.sp,),
          onTap: onPressed,
        ),
      ),
    ),
  );
}

Future<List<MealPlanModel>> fetchMealPlansByCalories(
    String name) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('meal_plans')
        .where('name', isEqualTo: name)
        .get();

    List<MealPlanModel> mealPlans = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return MealPlanModel.fromJson(doc.id, data);
    }).toList();
    return [mealPlans.first];
  } catch (e) {
    print('Error fetching meal plans: $e');
    return [];
  }
}

// Future<List<MealPlanModel>> fetchMealPlansByCalories(
//     String name, int totalCalories) async {
//   try {
//     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//         .collection('meal_plans')
//         .where('name', isEqualTo: name)
//         .where('totalCalories', isEqualTo: totalCalories)
//         .get();
//
//     List<MealPlanModel> mealPlans = querySnapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       return MealPlanModel.fromJson(doc.id, data);
//     }).toList();
//     print("meal plan is: ${mealPlans.first}");
// //    return [mealPlans.first];
//
//     if (mealPlans.isNotEmpty) {
//       mealPlans
//           .sort((a, b) => (a.totalCalories - totalCalories).abs().compareTo(
//                 (b.totalCalories - totalCalories).abs(),
//               ));
//       return [mealPlans.first];
//     } else {
//       return [];
//     }
//   } catch (e) {
//     print('Error fetching meal plans: $e');
//     return [];
//   }
// }
