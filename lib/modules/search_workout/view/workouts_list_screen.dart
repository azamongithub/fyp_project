import 'package:CoachBot/common_components/custom_list_tile.dart';
import 'package:CoachBot/modules/search_workout/view/workout_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/color_util.dart';
import '../../../theme/text_style_util.dart';
import '../components/workouts_list_tile.dart';

class WorkoutListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'WorkoutsDetails';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Workouts',
          style: CustomTextStyle.appBarStyle(),
        ),
        backgroundColor: AppColors.themeColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection(collectionName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var workouts = snapshot.data!.docs;
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 5.w),
            child: ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                var workout = workouts[index];
                var workoutData = workout.data() as Map<String, dynamic>;
                return WorkoutsListTile(
                  title: Text(workoutData['workoutName']),
                  subTitle: Text(workoutData['difficultyLevel']),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(workoutData['time'].split(' ')[0]),
                      const Text('min'),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkoutDetailsScreen(
                          workoutName: workoutData['workoutName'],
                          youtubeLink: workoutData['youtubeLink'],
                          steps: List.castFrom<dynamic, String>(
                              workoutData['steps']),
                          time: workoutData['time'],
                          reps: workoutData['reps'],
                          difficultyLevel: workoutData['difficultyLevel'],
                          equipments: List.castFrom<dynamic, String>(
                              workoutData['equipments']),
                          instructions: workoutData['instructions'],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
