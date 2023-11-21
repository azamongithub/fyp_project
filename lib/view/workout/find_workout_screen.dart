// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../view_model/search_exercise/search_exercise_provider.dart';
//
// class ExerciseListScreen extends StatelessWidget {
//   final String muscle;
//
//   ExerciseListScreen({required this.muscle});
//
//   @override
//   Widget build(BuildContext context) {
//     Provider.of<ExerciseDataProvider>(context, listen: false).fetchExerciseDataByMuscle(muscle);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Exercises for $muscle'),
//       ),
//       body: ChangeNotifierProvider(
//         create: (context) => ExerciseDataProvider(),
//         child: Consumer<ExerciseDataProvider>(
//           builder: (context, exerciseProvider, child) {
//             if (exerciseProvider.exercisesList.isEmpty) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else {
//               return ListView.builder(
//                 itemCount: exerciseProvider.exercisesList.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var exercise = exerciseProvider.exercisesList[index];
//                   print('Length: ${exerciseProvider.exercisesList.length.toString()}');
//                   return ListTile(
//                     title: Text(exercise.name),
//                     subtitle: Text(exerciseProvider.exercisesList.length.toString()),
//
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
//




import 'package:CoachBot/res/component/custom_button.dart';
import 'package:CoachBot/view_model/search_exercise/search_exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/component/input_text_field.dart';

class FindWorkoutsScreen extends StatelessWidget {
  final TextEditingController _muscleController = TextEditingController();
  late final isLoading;

  FindWorkoutsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseDataProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('All Workouts'),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Consumer<ExerciseDataProvider>(
            builder: (context, exerciseProvider, child) {
              bool hasSearchResult = exerciseProvider.exercisesList != null;
              bool hasError = exerciseProvider.loading;
              return Column(
                children: [
                  CustomTextField(
                    myController: _muscleController,
                    keyBoardType: TextInputType.text,
                    autoFocus: true,
                    labelText: 'Search by muscle name',
                    onChange: (value){
                      String muscle= _muscleController.text;
                      if (muscle.isNotEmpty) {
                        Provider.of<ExerciseDataProvider>(context,
                            listen: false)
                            .fetchExerciseDataByMuscle(muscle);
                      }
                    },
                    onValidator: (value) {
                      if (value == null) {}
                    },

                  ),
                  SizedBox(height: 20.h),
                  // CustomButton(
                  //     title: 'Search',
                  //     loading: exerciseProvider.loading,
                  //     onTap: () {
                  //       String muscle= _muscleController.text;
                  //       if (muscle.isNotEmpty) {
                  //         Provider.of<ExerciseDataProvider>(context,
                  //             listen: false)
                  //             .fetchExerciseDataByMuscle(muscle);
                  //       }
                  //     }),
                  SizedBox(height: 50.h),
                  hasError
                      ? const Center(
                    child: Text('searching...'),
                  )
                      : hasSearchResult
                      ? Expanded(
                    child:

                    ListView.builder(
                      itemCount: exerciseProvider.exercisesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var exercise = exerciseProvider.exercisesList[index];
                  print('Length: ${exerciseProvider.exercisesList.length.toString()}');
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text("Title ",
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(exercise.name),
                        ],
                      ),
                      Text("Workout Type: ${exercise.type}"),
                      Text("Difficulty Level: ${exercise.difficulty}"),
                      Text("Equipments Required: ${exercise.equipment}"),
                      Text("Instructions: ${exercise.instructions}"),
                    ],
                  );

                        }
                    ),
                  )
                      : Center(
                    child: Container(),
                  ),
                  // Center(
                  //         child: Container(),
                  //       ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
