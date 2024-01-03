import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_components/custom_button.dart';
import '../../../models/workout_plan_model.dart';
import '../../../theme/text_style_util.dart';
import '../services/workout_plan_services.dart';

class WorkoutPlanDetailsScreen extends StatelessWidget {
  final String day;
  final WorkoutDay dayDetails;

  const WorkoutPlanDetailsScreen({
    super.key,
    required this.day,
    required this.dayDetails,
  });

  List<Widget> buildExerciseWidgets(List<Exercise> exercises) {
    List<Widget> exerciseWidgets = [];

    for (var exercise in exercises) {
      List<Widget> descriptions =
          buildTextWidgets(exercise, '►', const TextStyle(fontSize: 16));

      exerciseWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: const TextStyle(fontSize: 24),
            ),
            ...descriptions,
            const SizedBox(height: 20),
          ],
        ),
      );
    }

    return exerciseWidgets;
  }

  List<Widget> buildTextWidgets(
      Exercise exercise, String prefix, TextStyle textStyle) {
    List<String> descriptions = [
      exercise.description1,
      exercise.description2,
      exercise.description3,
      exercise.description4,
    ];

    List<Widget> textWidgets = descriptions
        .where((description) => description.isNotEmpty)
        .map((description) => Text('$prefix $description', style: textStyle))
        .toList();

    return textWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          day,
          style: CustomTextStyle.appBarStyle(),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Exercises',
                    style: TextStyle(fontSize: 24),
                  ),
                  SizedBox(height: 20.h),
                  ...buildExerciseWidgets(dayDetails.exercises),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Center(
              child: CustomButton(
                title: 'Mark as Done',
                height: 50.h,
                width: 240.w,
                onTap: () {
                  WorkoutPlanServices.addProgress(day);
                },
              )),
        ),
        // Container(
        //   padding: EdgeInsets.only(bottom: 50.h),
        //   child: Center(
        //     child: ElevatedButton(
        //
        //       // onPressed:
        //       //     isButtonDisabled ? null : () => addProgress(widget.day),
        //       onPressed: () {
        //         addProgress(widget.day);
        //       },
        //       child: const Text('Mark as Done'),
        //     ),
        //   ),
        // ),
      ]),
    );
  }
}
