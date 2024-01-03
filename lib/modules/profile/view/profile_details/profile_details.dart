import 'package:CoachBot/routes/route_name.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../common_components/custom_list_tile.dart';
import '../../controller/profile_form_controller.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final userProfileStream = FirebaseFirestore.instance
        .collection('UserDataCollection')
        .doc(user!.uid)
        .snapshots();

    return StreamBuilder<DocumentSnapshot>(
      stream: userProfileStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final userData = snapshot.data!.data() as Map<String, dynamic>?;
        if (userData?['name'] == null) {
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
                      'It looks like you have not provided your Personal details'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.profileForm);
                    },
                    child: Text('Complete your Profile Details',
                        style: CustomTextStyle.textStyle18(
                            color: AppColors.themeColor)),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
            resizeToAvoidBottomInset: false,
            body: ChangeNotifierProvider(
              create: (_) => ProfileFormController(),
              child: Consumer<ProfileFormController>(
                  builder: (context, provider, child) {
                return SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 14.h, horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomListTile(
                          iconData: Icons.email,
                          title: Text('Email', style: CustomTextStyle.textStyle18()),
                          subTitle: Text(userData?['email'], style: CustomTextStyle.textStyle14()),
                        ),
                        //Divider(color: Colors.grey.withOpacity(0.8)),
                        CustomListTile(
                          title: Text('Name',style: CustomTextStyle.textStyle18()),
                          trailing: Text(userData?['name'], style: CustomTextStyle.textStyle14()),
                          iconData: FontAwesomeIcons.userLarge,
                        ),
                        CustomListTile(
                          title: Text('Gender', style: CustomTextStyle.textStyle18()),
                          trailing: Text(userData?['gender'] == 'M'
                              ? 'Male'
                              : userData?['gender'] == 'F'
                                  ? 'Female'
                                  : 'Not Found', style: CustomTextStyle.textStyle14()),
                          iconData: FontAwesomeIcons.venusMars,
                        ),
                        CustomListTile(
                          title: Text('Date of birth', style: CustomTextStyle.textStyle18()),
                          trailing: Text(userData?['dateOfBirth'] != null
                              ? DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(userData!['dateOfBirth']))
                              : '', style: CustomTextStyle.textStyle14()),
                          iconData: FontAwesomeIcons.cakeCandles,
                        ),
                        CustomListTile(
                          title: Text('Age', style: CustomTextStyle.textStyle18()),
                          trailing: Text(userData?['age'] != null
                              ? '${userData!['age']} Years'
                              : '', style: CustomTextStyle.textStyle14()),
                          iconData: FontAwesomeIcons.solidCalendarDays,
                        ),
                        CustomListTile(
                          title: Text('Age Group', style: CustomTextStyle.textStyle18()),
                          trailing: Text(userData?['ageGroup'] ?? '', style: CustomTextStyle.textStyle14()),
                          iconData: FontAwesomeIcons.children,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ));
      },
    );
  }
}
