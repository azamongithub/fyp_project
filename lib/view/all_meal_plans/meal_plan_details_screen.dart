import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MealPlanDetailsScreen extends StatelessWidget {
  final String day;
  final Map<String, dynamic> dayDetails;

  List<Widget> buildTextWidgets(Map<String, dynamic>? titles, String prefix) {
    List<Widget> textWidgets = [];

    if (titles != null) {
      titles.forEach((key, value) {
        if (value != null) {
          textWidgets.add(Text('$prefix $value'));
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
        title: Text(day),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Breakfast',
              style: TextStyle(
                fontSize: 24,
              ),
              ),
              ...buildTextWidgets(dayDetails['breakfast'], '►'),

              SizedBox(height: 40.h,),
              const Text('Morning Snack',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ...buildTextWidgets(dayDetails['morningSnack'], '►'),
              SizedBox(height: 40.h,),
              const Text('Lunch',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ...buildTextWidgets(dayDetails['lunch'], '►'),
              SizedBox(height: 40.h,),
              const Text('Afternoon Snack',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ...buildTextWidgets(dayDetails['afternoonSnack'], '►'),
              SizedBox(height: 40.h,),
              const Text('Dinner',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              ...buildTextWidgets(dayDetails['dinner'], '►'),
              // Add more details as needed
            ],
        ),
        ),
      ),
    );
  }
}
