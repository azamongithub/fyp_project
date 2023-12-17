import 'package:CoachBot/models/workout_plan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../theme/text_style_util.dart';
import '../../../routes/route_name.dart';

class WorkoutPlanDaysScreen extends StatelessWidget {
  final String name;
  final String? disease;
  final String? workoutPlanId;

  WorkoutPlanDaysScreen({
    super.key,
    required this.name,
    this.disease,
    this.workoutPlanId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('Workout Plan ', style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
      ),
      body: FutureBuilder(
        future: fetchWorkoutPlan(name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No Data Found'),
            );
          }
          WorkoutPlanModel workoutPlan = snapshot.data!;
          Map<String, int> weekdaysMap = {
            'Monday': DateTime.monday,
            'Tuesday': DateTime.tuesday,
            'Wednesday': DateTime.wednesday,
            'Thursday': DateTime.thursday,
            'Friday': DateTime.friday,
            'Saturday': DateTime.saturday,
            'Sunday': DateTime.sunday,
          };
          List<MapEntry<String, WorkoutDay>> orderedDays =
          workoutPlan.days.entries.toList()
            ..sort((a, b) {
              return weekdaysMap[a.key]! - weekdaysMap[b.key]!;
            });
          return ListView(
            children: [
              for (var dayEntry in orderedDays)
                workoutDaysCard(
                  day: dayEntry.key,
                  name: workoutPlan.name,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteName.workoutPlanDetailsScreen,
                      arguments: {
                        'day': dayEntry.key,
                        'dayDetails': dayEntry.value,
                      },
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

Widget workoutDaysCard({
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
          subtitle: Text(
            name!,
            style: CustomTextStyle.subTitleStyle14(),
          ),
          trailing: Icon(Icons.arrow_forward, size: 28.sp,),
          onTap: onPressed,
        ),
      ),
    ),
  );
}

Future<WorkoutPlanModel> fetchWorkoutPlan(String name) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('workout_plans')
        .where('name', isEqualTo: name)
        .get();

    List<WorkoutPlanModel> workoutPlans = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return WorkoutPlanModel.fromJson(doc.id, data);
    }).toList();

    if (workoutPlans.isNotEmpty) {
      return workoutPlans.first;
    } else {
      return Future.error('No data found for workout plan: $name');
    }
  } catch (e) {
    print('Error fetching workout plans: $e');
    throw e;
  }
}
