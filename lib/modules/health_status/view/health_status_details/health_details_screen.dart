import 'package:CoachBot/modules/health_status/components/none_other_disease.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../routes/route_name.dart';
import '../../../../theme/color_util.dart';
import '../../../send_msg_to_email/send_msg_to_email_screen.dart';
import '../../components/rest_diseases.dart';

class HealthDetailsScreen extends StatelessWidget {
  const HealthDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 70.h),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('UserDataCollection')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Scaffold(
                      body: Center(child: Text('No data available')),
                    );
                  }
                  final userData = snapshot.data!.data();
                  if (userData == null) {
                    return Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Container(
                        padding: EdgeInsets.all(40.sp),
                        color: AppColors.whiteColor,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'It looks like you have not provided information about your health status'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, RouteName.healthStatusForm);
                              },
                              child: Text('Select your health status',
                                  style: CustomTextStyle.textStyle18(
                                      color: AppColors.themeColor)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else if (snapshot.data!['disease'] == 'other') {
                    return const NoneOtherDisease(diseaseId: 'other');
                  }
                  else if(snapshot.data!['disease'] == 'none'){
                    return const NoneOtherDisease(diseaseId: 'none');
                  }
                  else {
                    String diseaseId = snapshot.data!['disease'];
                    return RestDiseases(diseaseId: diseaseId);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) =>
                  const SendMsgToEmailScreen()));
        },
        icon: const Icon(Icons.contact_page, color: AppColors.whiteColor),
        label: const Text('Contact Doctor', style: TextStyle(color: AppColors.whiteColor)),
        backgroundColor: AppColors.themeColor,
      ),
    );



  }
}


