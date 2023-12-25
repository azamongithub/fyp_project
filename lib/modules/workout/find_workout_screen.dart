import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../common_components/custom_text_field.dart';
import '../../theme/text_style_util.dart';
import '../search_exercise/controller/search_exercise_controller.dart';

class FindWorkoutsScreen extends StatelessWidget {
  final TextEditingController _muscleController = TextEditingController();
  late final isLoading;

  FindWorkoutsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseDataController(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text('Find Workout ', style: CustomTextStyle.appBarStyle()),
          backgroundColor: const Color(0xff3140b0),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 25.h),
          child: Consumer<ExerciseDataController>(
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
                    onChange: (value) {
                      String muscle = _muscleController.text;
                      if (muscle.isNotEmpty) {
                        Provider.of<ExerciseDataController>(context,
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
                              child: ListView.builder(
                                  itemCount:
                                      exerciseProvider.exercisesList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var exercise =
                                        exerciseProvider.exercisesList[index];
                                    if (kDebugMode) {
                                      print(
                                        'Length: ${exerciseProvider.exercisesList.length.toString()}');
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Text(
                                              "Title ",
                                              style: TextStyle(
                                                fontSize: 22,
                                              ),
                                            ),
                                            Text(exercise.name),
                                          ],
                                        ),
                                        Text("Workout Type: ${exercise.type}"),
                                        Text(
                                            "Difficulty Level: ${exercise.difficulty}"),
                                        Text(
                                            "Equipments Required: ${exercise.equipment}"),
                                        Text(
                                            "Instructions: ${exercise.instructions}"),
                                      ],
                                    );
                                  }),
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
