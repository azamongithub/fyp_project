import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/DiseaseDataModel.dart';
import '../../../theme/color_util.dart';
import '../../../theme/text_style_util.dart';
import '../../send_msg_to_email/send_msg_to_email_screen.dart';
import '../controller/health_status_controller.dart';
import '../view/select_health_status/health_status_screen.dart';

class NoneOtherDisease extends StatelessWidget {
  final String diseaseId;
  const NoneOtherDisease({
    Key? key,
    required this.diseaseId,
  }) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        disease.name,
                        style: CustomTextStyle.textStyle22(
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
                    style: CustomTextStyle.textStyle20(
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${disease.data['introduction']}',
                    style: CustomTextStyle.textStyle16(),
                  ),
                  Text(
                    'Suggestions',
                    style: CustomTextStyle.textStyle20(
                        fontWeight: FontWeight.w600),
                  ),
                  ...List<Widget>.generate(
                    (disease.data['suggestions'] as List).length,
                    (index) => Text(
                      '> ${disease.data['suggestions'][index]}',
                      style: CustomTextStyle.textStyle16(),
                    ),
                  ),
                  Text(
                    'Conclusion',
                    style: CustomTextStyle.textStyle20(
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '${disease.data['conclusion']}',
                    style: CustomTextStyle.textStyle16(),
                  ),
                  diseaseId == 'other'
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.h),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      CupertinoPageRoute(
                                          builder: (context) =>
                                              const SendMsgToEmailScreen()));
                                },
                                child: Text('Contact our doctor',
                                    style: CustomTextStyle.customTextStyle(
                                        color: AppColors.themeColor,
                                        fontSize: 18.sp,
                                        underline: true)),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
