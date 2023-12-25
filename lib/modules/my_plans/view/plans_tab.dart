import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../routes/route_name.dart';
import '../../../theme/text_style_util.dart';
import '../controller/my_plans_controller.dart';

class PlansTab extends StatefulWidget {
  const PlansTab({super.key});

  @override
  State<PlansTab> createState() => _PlansTabState();
}

class _PlansTabState extends State<PlansTab> {
  @override
  void initState() {
    super.initState();
    MyPlansController myPlansController =
        Provider.of<MyPlansController>(context, listen: false);
    myPlansController.fetchAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myPlans, style: CustomTextStyle.appBarStyle()),
        backgroundColor: const Color(0xff3140b0),
        automaticallyImplyLeading: false,
      ),
      body: Consumer<MyPlansController>(builder: (context, provider, _) {
        return provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
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
                              if (kDebugMode) {
                                print(
                                    'Workout Plan is: ${provider.workoutPlan}');
                              }
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
                              if (kDebugMode) {
                                print('Meal Plan is: ${provider.mealPlan}');
                              }
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
      }),
    );
  }
}

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
