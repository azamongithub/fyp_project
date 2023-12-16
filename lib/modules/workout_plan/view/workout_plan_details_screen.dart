import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachBot/theme/text_style_util.dart';

import '../../../models/workout_plan_model.dart';

class WorkoutPlanDetailsScreen extends StatelessWidget {
  final String day;
  final WorkoutDay dayDetails;

  List<Widget> buildExerciseWidgets(List<Exercise> exercises) {
    List<Widget> exerciseWidgets = [];

    for (var exercise in exercises) {
      // Build Text widgets for each exercise
      List<Widget> descriptions = buildTextWidgets(exercise, '►', CustomTextStyle.textStyle16());

      exerciseWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              exercise.name,
              style: CustomTextStyle.textStyle24(),
            ),
            ...descriptions,
            SizedBox(height: 20.h),
          ],
        ),
      );
    }

    return exerciseWidgets;
  }

  List<Widget> buildTextWidgets(Exercise exercise, String prefix, TextStyle textStyle) {
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

  // List<Widget> buildTextWidgets(Exercise exercise, String prefix, TextStyle textStyle) {
  //   List<Widget> textWidgets = [];
  //
  //   if (exercise.description1.isNotEmpty) {
  //     textWidgets.add(Text('$prefix ${exercise.description1}', style: textStyle));
  //   }
  //   if (exercise.description2.isNotEmpty) {
  //     textWidgets.add(Text('$prefix ${exercise.description2}', style: textStyle));
  //   }
  //   if (exercise.description3.isNotEmpty) {
  //     textWidgets.add(Text('$prefix ${exercise.description3}', style: textStyle));
  //   }
  //   if (exercise.description4.isNotEmpty) {
  //     textWidgets.add(Text('$prefix ${exercise.description4}', style: textStyle));
  //   }
  //
  //   return textWidgets;
  // }

  WorkoutPlanDetailsScreen({
    required this.day,
    required this.dayDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          day,
          style: CustomTextStyle.appBarStyle(),
        ),
        backgroundColor: const Color(0xff3140b0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exercises',
                style: CustomTextStyle.textStyle24(),
              ),
              SizedBox(height: 20.h),
              ...buildExerciseWidgets(dayDetails.exercises),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}