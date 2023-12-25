import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/workout_plan_model.dart';
import '../../../theme/text_style_util.dart';

class WorkoutPlanDetailsScreen extends StatefulWidget {
  final String day;
  final WorkoutDay dayDetails;

  const WorkoutPlanDetailsScreen({
    super.key,
    required this.day,
    required this.dayDetails,
  });

  @override
  State<WorkoutPlanDetailsScreen> createState() =>
      _WorkoutPlanDetailsScreenState();
}

class _WorkoutPlanDetailsScreenState extends State<WorkoutPlanDetailsScreen> {
  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    initializeButtonState();
  }

  Future<void> initializeButtonState() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final workoutProgressRef = FirebaseFirestore.instance
          .collection('WorkoutProgress')
          .doc(user.uid);
      try {
        DocumentSnapshot progressSnapshot = await workoutProgressRef.get();
        if (progressSnapshot.exists) {
          String day = widget.day;
          DateTime? lastTappedDate = progressSnapshot[day] != null
              ? (progressSnapshot[day] as Timestamp).toDate()
              : null;

          // If lastTappedDate is null or more than 7 days old, enable the button
          setState(() {
            isButtonDisabled = lastTappedDate == null ||
                DateTime.now().difference(lastTappedDate) >=
                    const Duration(seconds: 5);
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error initializing button state: $e');
        }
      }
    }
  }

  Future<void> addProgress(String day) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && !isButtonDisabled) {
      final workoutProgressRef = FirebaseFirestore.instance
          .collection('WorkoutProgress')
          .doc(user.uid);
      try {
        DocumentSnapshot progressSnapshot = await workoutProgressRef.get();
        Map<String, dynamic>? dayData = progressSnapshot.exists
            ? progressSnapshot.data() as Map<String, dynamic>?
            : null;
        int currentProgress = progressSnapshot.exists
            ? progressSnapshot['totalProgress'] ?? 0
            : 0;
        if (dayData == null || !dayData.containsKey(day)) {
          // Create the day field dynamically
          dayData ??= {};
          dayData[day] = FieldValue.serverTimestamp();
          await workoutProgressRef.set({
            'totalProgress': currentProgress + 1,
            ...dayData,
          });
          Utils.positiveToastMessage('Progress for $day has added.');
          if (kDebugMode) {
            print('Progress for $day added.');
          }
        } else {
          Utils.positiveToastMessage('Progress for $day has already added.');
          if (kDebugMode) {
            print('Progress for $day already added.');
          }
        }
        setState(() {
          isButtonDisabled = true;
        });

        //Re-enable the button after a delay (adjust as needed)
        Future.delayed(const Duration(seconds: 1), () async {
          setState(() {
            isButtonDisabled = false;
          });
          // Print statement to check if the button is being re-enabled
          if (kDebugMode) {
            print('Button re-enabled after delay.');
          }
        });
      } catch (e) {
        if (kDebugMode) {
          print('Error updating progress: $e');
        }
      }
    }
  }

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
          widget.day,
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
                  ...buildExerciseWidgets(widget.dayDetails.exercises),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 50.h),
          child: Center(
            child: ElevatedButton(
              onPressed:
                  isButtonDisabled ? null : () => addProgress(widget.day),
              child: const Text('Mark as Done'),
            ),
          ),
        ),
      ]),
    );
  }
}
