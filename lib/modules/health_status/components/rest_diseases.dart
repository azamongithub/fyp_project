import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/DiseaseDataModel.dart';
import '../../../theme/text_style_util.dart';
import '../controller/health_status_controller.dart';
import '../view/select_health_status/health_status_screen.dart';

class RestDiseases extends StatelessWidget {
  final String diseaseId;
  const RestDiseases({Key? key, required this.diseaseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diseaseProvider =
        Provider.of<HealthStatusController>(context, listen: false);
    return StreamBuilder<Disease?>(
      stream: diseaseProvider.fetchDiseaseByIdStream(diseaseId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('Disease not found.'),
          );
        } else {
          Disease disease = snapshot.data!;
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        disease.name,
                        style: CustomTextStyle.textStyle24(
                            fontWeight: FontWeight.w600),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const HealthStatusForm(
                                    isEdit: true,
                                  )));
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.themeColor,
                          size: 30.sp,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '${disease.data['description']}',
                    style: CustomTextStyle.textStyle18(),
                  ),
                  Text(
                    'Symptoms',
                    style: CustomTextStyle.textStyle20(
                        fontWeight: FontWeight.w600),
                  ),
                  ...List<Widget>.generate(
                    (disease.data['symptoms'] as List).length,
                    (index) => Text(
                      '> ${disease.data['symptoms'][index]}',
                      style: CustomTextStyle.textStyle18(),
                    ),
                  ),
                  Text(
                    'Things to Avoid',
                    style: CustomTextStyle.textStyle20(
                        fontWeight: FontWeight.w600),
                  ),
                  ...List<Widget>.generate(
                    (disease.data['things_to_avoid'] as List).length,
                    (index) => Text(
                      '> ${disease.data['things_to_avoid'][index]}',
                      style: CustomTextStyle.textStyle18(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
