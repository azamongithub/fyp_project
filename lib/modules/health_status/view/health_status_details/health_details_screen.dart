import 'package:CoachBot/theme/text_style_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../controller/health_status_controller.dart';

class HealthDetails extends StatelessWidget {
  const HealthDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userHealthStream = FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: userHealthStream,
      builder: (ctx, snapshot) {
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
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        return Scaffold(
          body: ChangeNotifierProvider(
              create: (_) => HealthStatusController(),
            child: Consumer<HealthStatusController>(
              builder: (context, provider, child){
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Disease',
                          style: TextStyle(
                            fontSize: 24,
                            //color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '🔵 ${userData?['disease']?? ''}',
                          style: CustomTextStyle.textStyle20(),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                );
              }
            )
          )

        );
      },
    );
  }
}
