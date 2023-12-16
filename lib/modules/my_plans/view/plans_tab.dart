import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../controller/my_plans_controller.dart';

class PlansTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MyPlansController>(context, listen: false);
    provider.fetchData();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myPlans, style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MyPlansController>(
        builder: (context, provider, _) {
          return FutureBuilder(
            future: provider.fetchData(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        AppStrings.customizedPlans,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: [
                            myPlansCard(
                              title: AppStrings.workoutPlan,
                              description: AppStrings.checkWorkoutPlan,
                              onPressed: () async {
                                print(
                                    'Workout Plan is: ${provider.workoutPlan}');
                                await Navigator.pushNamed(
                                  context,
                                  RouteName.workoutPlanDaysScreen,
                                  arguments: {
                                    'name': provider.workoutPlan,
                                  },
                                );
                              },
                            ),
                            myPlansCard(
                              title: AppStrings.mealPlan,
                              description: AppStrings.checkMealPlan,
                              onPressed: () async {
                                print('Meal Plan is: ${provider.mealPlan}');
                                await Navigator.pushNamed(
                                  context,
                                  RouteName.mealPlanDaysScreen,
                                  arguments: {
                                    'name': provider.mealPlan,
                                  },
                                );
                              },
                            ),
                            // Add more workout cards as needed
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
    ),
    );
  }
}


// class PlansTab extends StatelessWidget {
//   late final double retrievedCalories;
//   late String mealPlan;
//   late String workoutPlan;
//
//   PlansTab({super.key}) {
//     // throw UnimplementedError();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser;
//
//     Future<void> fetchAllPlans() async {
//       try {
//         CollectionReference userFitnessCollection =
//         FirebaseFirestore.instance.collection('UserDataCollection');
//         DocumentSnapshot userSnapshot =
//         await userFitnessCollection.doc(user!.uid).get();
//         retrievedCalories = userSnapshot['calories'];
//         mealPlan = userSnapshot['meal_plan'];
//         workoutPlan = userSnapshot['workout_plan'];
//         if (kDebugMode) {
//           print('Calories: $retrievedCalories');
//         }
//       } catch (e) {
//         if (kDebugMode) {
//           print('Error fetching calories: $e');
//         }
//       }
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppStrings.myPlans, style: CustomTextStyle.appBarStyle()),
//         backgroundColor: const Color(0xff3140b0),
//         automaticallyImplyLeading: false,
//       ),
//       body: FutureBuilder(
//         future: fetchAllPlans(),
//     builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//     return const Center(child: CircularProgressIndicator());
//     } else if (snapshot.hasError) {
//     return Text('Error: ${snapshot.error}');
//     }
//     else {
//       return Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               AppStrings.customizedPlans,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView(
//                 children: [
//                   myPlansCard(
//                     title: AppStrings.workoutPlan,
//                     description: AppStrings.checkWorkoutPlan,
//                     onPressed: () async {
//                       print('Workout Plan is: $workoutPlan');
//                       await  Navigator.pushNamed(
//                         context,
//                         RouteName.workoutPlanDaysScreen,
//                         arguments: {
//                           'name': workoutPlan,
//                         },
//                       );
//                     },
//                   ),
//                   myPlansCard(
//                     title: AppStrings.mealPlan,
//                     description: AppStrings.checkMealPlan,
//                     onPressed: () async {
//                       print('Meal Plan is: $mealPlan');
//                       await    Navigator.pushNamed(
//                         context,
//                         RouteName.mealPlanDaysScreen,
//                         arguments: {
//                           'name': mealPlan,
//                         },
//                       );
//                     },
//                   ),
//                   // Add more workout cards as needed
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     }
//       ),
//     );
//   }
// }

Widget myPlansCard({
  required String title,
  required String description,
  required VoidCallback onPressed,
}) {
  return Card(
    child: ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: const Icon(Icons.arrow_forward),
      onTap: onPressed,
    ),
  );
}
