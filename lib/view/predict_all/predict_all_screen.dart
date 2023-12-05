import 'package:flutter/material.dart';
import '../../services/api_repository.dart';

class PredictAllPlansScreen extends StatefulWidget {
  @override
  _PredictAllPlansScreenState createState() => _PredictAllPlansScreenState();
}

class _PredictAllPlansScreenState extends State<PredictAllPlansScreen> {
  Map<String, dynamic> responseData = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final requestData = {
        "Age": 26,
        "Gender": "M",
        "Height": 5.94,
        "Weight": 70,
        "Fitness_Level": "Overweight",
        "Fitness_Goal": "weight loss",
        "Medical_History": "none"
      };

      //final response = await ApiService.fetchData(requestData);

      setState(() {
        //responseData = response;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter FastAPI Integration'),
      ),
      body: Center(
        child: responseData.isEmpty
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Text('Meal Plan: ${responseData['meal_plan']}'),
            ),
            ListTile(
              title: Text('Calories: ${responseData['calories']}'),
            ),
            ListTile(
              title: Text('Workout Plan: ${responseData['workout_plan']}'),
            ),


          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../bottom_nav_tabs/dashboard/dashboard_controller.dart';
//
// class PredictAllPlansScreen extends StatelessWidget {
//   const PredictAllPlansScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final apiController = Provider.of<DashboardController>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('All Plans'),
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               ApiDataWidget(),
//               ElevatedButton(
//                 onPressed: () {
//                   apiController.fetchApiData(
//                       {
//                         "Age": 26,
//                         "Gender": "M",
//                         "Height": 5.94,
//                         "Weight": 70,
//                         "Fitness_Level": "Overweight",
//                         "Fitness_Goal": "weight loss",
//                         "Medical_History": "Diabetes"
//                       }
//                   );
//                 },
//                 child: const Text('View Plan'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ApiDataWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final apiController = Provider.of<DashboardController>(context);
//
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text('Meal Plan: ${apiController.apiData.mealPlan}'),
//         Text('Calories: ${apiController.apiData.calories.toString()}'),
//         Text('Workout Plan: ${apiController.apiData.workoutPlan}'),
//       ],
//     );
//   }
// }
