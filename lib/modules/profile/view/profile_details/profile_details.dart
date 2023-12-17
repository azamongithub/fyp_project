import 'package:CoachBot/routes/route_name.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/theme/text_style_util.dart';
import 'package:CoachBot/utils/utils.dart';
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
      builder: (ctx, snapshot) {
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
              color: ColorUtil.whiteColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('It looks like you have not provided your Personal details'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RouteName.profileForm);
                    },
                    child: Text('Complete your Profile Details', style: CustomTextStyle.textStyle18(color: ColorUtil.themeColor)),
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
                    padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: const Text('Email'),
                          subtitle: Text(userData?['email']),
                        ),
                        Divider(color: Colors.grey.withOpacity(0.8)),
                        CustomListTile(
                          title: const Text('Name'),
                          trailing: Text(userData?['name']),
                          iconData: FontAwesomeIcons.userLarge,
                        ),
                        CustomListTile(
                          title: const Text('Gender'),
                          trailing: Text(userData?['gender'] == 'M' ? 'Male': userData?['gender'] == 'F' ? 'Female' : 'Not Found'),
                          iconData: FontAwesomeIcons.venusMars,
                        ),
                        CustomListTile(
                          title: const Text('Date of birth'),
                          trailing: Text(userData?['dateOfBirth'] != null
                              ? DateFormat('yyyy-MM-dd').format(
                                  DateTime.parse(userData!['dateOfBirth']))
                              : ''),
                          iconData: FontAwesomeIcons.cakeCandles,
                        ),
                        CustomListTile(
                          title: const Text('Age'),
                          trailing: Text(userData?['age'] != null
                              ? '${userData!['age']} Years'
                              : ''),
                          iconData: FontAwesomeIcons.solidCalendarDays,
                        ),
                        CustomListTile(
                          title: const Text('Age Group'),
                          trailing: Text(userData?['ageGroup'] ?? ''),
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
