import 'package:CoachBot/theme/color_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import '../../../../utils/utils.dart';

class MealPlanDetailsScreen extends StatefulWidget {
  final String day;
  final Map<String, dynamic> dayDetails;

  const MealPlanDetailsScreen(
      {super.key, required this.day, required this.dayDetails});

  @override
  State<MealPlanDetailsScreen> createState() => _MealPlanDetailsScreenState();
}

class _MealPlanDetailsScreenState extends State<MealPlanDetailsScreen> {
  bool isButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    initializeButtonState();
  }

  Future<void> initializeButtonState() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final mealProgressRef =
          FirebaseFirestore.instance.collection('MealProgress').doc(user.uid);
      try {
        DocumentSnapshot progressSnapshot = await mealProgressRef.get();
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
      final workoutProgressRef =
          FirebaseFirestore.instance.collection('MealProgress').doc(user.uid);
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

  List<Widget> buildTextWidgets(
      Map<String, dynamic>? titles, String prefix, TextStyle textStyle) {
    List<Widget> textWidgets = [];

    if (titles != null) {
      titles.forEach((key, value) {
        if (value != null) {
          textWidgets.add(Text('$prefix $value', style: textStyle));
        }
      });
    }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Breakfast',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(widget.dayDetails['breakfast'], '►',
                  CustomTextStyle.textStyle16()),

              SizedBox(
                height: 40.h,
              ),
              Text(
                'Morning Snack',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(widget.dayDetails['morningSnack'], '►',
                  CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Lunch',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(widget.dayDetails['lunch'], '►',
                  CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Afternoon Snack',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(widget.dayDetails['afternoonSnack'], '►',
                  CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Dinner',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(widget.dayDetails['dinner'], '►',
                  CustomTextStyle.textStyle16()),

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
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}
