import 'package:CoachBot/common_components/custom_button.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachBot/theme/text_style_util.dart';

import '../../services/meal_plan_services.dart';

class MealPlanDetailsScreen extends StatelessWidget {
  final String day;
  final Map<String, dynamic> dayDetails;

  const MealPlanDetailsScreen(
      {super.key, required this.day, required this.dayDetails});

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
          day,
          style: CustomTextStyle.appBarStyle(),
        ),
        backgroundColor: AppColors.themeColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Breakfast',
                      style: CustomTextStyle.textStyle24(),
                    ),
                    ...buildTextWidgets(dayDetails['breakfast'], '►',
                        CustomTextStyle.textStyle16()),

                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Morning Snack',
                      style: CustomTextStyle.textStyle24(),
                    ),
                    ...buildTextWidgets(dayDetails['morningSnack'], '►',
                        CustomTextStyle.textStyle16()),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Lunch',
                      style: CustomTextStyle.textStyle24(),
                    ),
                    ...buildTextWidgets(dayDetails['lunch'], '►',
                        CustomTextStyle.textStyle16()),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Afternoon Snack',
                      style: CustomTextStyle.textStyle24(),
                    ),
                    ...buildTextWidgets(dayDetails['afternoonSnack'], '►',
                        CustomTextStyle.textStyle16()),
                    SizedBox(
                      height: 40.h,
                    ),
                    Text(
                      'Dinner',
                      style: CustomTextStyle.textStyle24(),
                    ),
                    ...buildTextWidgets(dayDetails['dinner'], '►',
                        CustomTextStyle.textStyle16()),

                    // Add more details as needed
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
                    MealPlanServices.addProgress(day);
                  },
                )),
          ),
        ]
      ),
    );
  }
}
