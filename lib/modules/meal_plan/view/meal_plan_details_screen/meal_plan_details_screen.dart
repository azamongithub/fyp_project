import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import '../../../../constants/AppColors.dart';

class MealPlanDetailsScreen extends StatelessWidget {
  final String day;
  final Map<String, dynamic> dayDetails;

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

  MealPlanDetailsScreen({required this.day, required this.dayDetails});

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
                'Breakfast',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['breakfast'], '►', CustomTextStyle.textStyle16()),

              SizedBox(
                height: 40.h,
              ),
              Text(
                'Morning Snack',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['morningSnack'], '►', CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Lunch',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['lunch'], '►', CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Afternoon Snack',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['afternoonSnack'], '►', CustomTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Dinner',
                style: CustomTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['dinner'], '►', CustomTextStyle.textStyle16()),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}