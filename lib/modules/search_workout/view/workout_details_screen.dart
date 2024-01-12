import 'package:CoachBot/modules/search_workout/components/workouts_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../theme/color_util.dart';
import '../../../theme/text_style_util.dart';

class WorkoutDetailsScreen extends StatelessWidget {
  final String workoutName;
  final String gifImageLink;
  final List<String> steps;
  final String difficultyLevel;
  final List<String> equipments;
  final List<String> primaryMuscles;
  final List<String> secondaryMuscles;
  final String instructions;
  final List<String> commonMistakes;

  const WorkoutDetailsScreen({
    super.key,
    required this.workoutName,
    required this.gifImageLink,
    required this.steps,
    required this.difficultyLevel,
    required this.equipments,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.instructions,
    required this.commonMistakes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(workoutName, style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
        Image.network(
        gifImageLink,
          fit: BoxFit.cover,
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            } else {
              return SizedBox(
                height: 1.sh * 0.4,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Loading Gif image...',
                        ),
                      ),
                    ),
                    LinearProgressIndicator(minHeight: 10),
                  ],
                ),
              );
            }
          },
        ),
            // Image.network(
            //   gifImageLink,
            //   fit: BoxFit.cover,
            //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            //     if (loadingProgress == null) {
            //       return child;
            //     } else {
            //       return SizedBox(
            //         height: 1.sh * 0.4,
            //         child: const Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           children: [
            //             Text('Loading Gif image...'),
            //             SizedBox(height: 50),
            //             LinearProgressIndicator(minHeight: 6),
            //           ],
            //         ),
            //       );
            //     }
            //   },
            // ),
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WorkoutsListTile(
                      title: Text('Difficulty Level', style: CustomTextStyle.textStyle18()),
                    trailing: Text(difficultyLevel, style: CustomTextStyle.textStyle14()),
                    leading: const Icon(Icons.sports_handball),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  equipments.contains('None') ?
                  WorkoutsListTile(
                    title: Text('Equipments', style: CustomTextStyle.textStyle18()),
                    trailing: Text(equipments.join(', '), style: CustomTextStyle.textStyle14()),
                    leading: const Icon(Icons.fitness_center),
                  ):
                  Column(
                    children: [
                      Text(
                        'Equipments',
                        style: CustomTextStyle.textStyle18(fontWeight: FontWeight.w600),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Text('► ${equipments.join('\n►')}',
                              style: CustomTextStyle.textStyle14()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '🟥 Primary Muscles',
                    style: CustomTextStyle.textStyle18(fontWeight: FontWeight.w600),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Text('►  ${primaryMuscles.join('\n►  ')}',
                          style: CustomTextStyle.textStyle14()),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '🟧 Secondary Muscles',
                    style: CustomTextStyle.textStyle18(fontWeight: FontWeight.w600),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Text('►  ${secondaryMuscles.join('\n►  ')}',
                          style: CustomTextStyle.textStyle14()),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '💡 Expert Advice',
                    style: CustomTextStyle.textStyle18(fontWeight: FontWeight.w600),
                  ),
                  Card(
                      child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Text(instructions,
                              style: CustomTextStyle.textStyle14()))),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    '🧾 Steps',
                    style: CustomTextStyle.textStyle18(fontWeight: FontWeight.w600),
                  ),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Text('► ${steps.join('\n►')}',
                          style: CustomTextStyle.textStyle14()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
