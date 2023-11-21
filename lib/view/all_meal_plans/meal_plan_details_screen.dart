import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachBot/theme/text_style_util.dart';

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
        title: Text(
            day,
        style: MyTextStyle.appBarStyle(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Breakfast',
                style: MyTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['breakfast'], '►', MyTextStyle.textStyle16()),

              SizedBox(
                height: 40.h,
              ),
              Text(
                'Morning Snack',
                style: MyTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['morningSnack'], '►', MyTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Lunch',
                style: MyTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['lunch'], '►', MyTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Afternoon Snack',
                style: MyTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['afternoonSnack'], '►', MyTextStyle.textStyle16()),
              SizedBox(
                height: 40.h,
              ),
              Text(
                'Dinner',
                style: MyTextStyle.textStyle24(),
              ),
              ...buildTextWidgets(dayDetails['dinner'], '►', MyTextStyle.textStyle16()),
              // Add more details as needed
            ],
          ),
        ),
      ),
    );
  }
}