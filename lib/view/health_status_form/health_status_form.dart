import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../res/component/bottom_nav_bar.dart';
import '../../res/component/custom_card.dart';
import '../../theme/text_style_util.dart';
import '../../utils/utils.dart';
import '../../res/component/custom_button.dart';
import 'package:CoachBot/constants/app_string_constants.dart';
import 'health_status_provider.dart';

class HealthStatusForm extends StatelessWidget {
  const HealthStatusForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthFormController>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(AppStrings.yourMedicalCondition),
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Center(
                  child: Text(
                    'Select any one to find your health status',
                    style: MyTextStyle.textStyle22(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                CustomCard(
                  title: 'Diabetes',
                  isSelected: provider.selectedDisease == 'Diabetes',
                  onTap: () {
                    provider.setSelectedDisease('Diabetes');
                  },
                ),
                CustomCard(
                  title: 'Hypercholesterolemia',
                  isSelected: provider.selectedDisease == 'Hypercholesterolemia',
                  onTap: () {
                    provider.setSelectedDisease('Hypercholesterolemia');
                  },
                ),
                CustomCard(
                  title: 'Celiac',
                  isSelected: provider.selectedDisease == 'Celiac',
                  onTap: () {
                    provider.setSelectedDisease('Celiac');
                  },
                ),
                CustomCard(
                  title: 'Gout',
                  isSelected: provider.selectedDisease == 'Gout',
                  onTap: () {
                    provider.setSelectedDisease('Gout');
                  },
                ),
                CustomCard(
                  title: 'None',
                  isSelected: provider.selectedDisease == 'None',
                  onTap: () {
                    provider.setSelectedDisease('None');
                  },
                ),
                SizedBox(height: 30.h),
                CustomButton(
                  title: 'Continue',
                  loading: provider.isLoading,
                  onTap: () async {
                    if (provider.selectedDisease != null) {
                      provider.setIsLoading(true);
                      provider.saveHealthDetails(context);

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                      );
                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   RouteName.BottomNavBar,
                      //       (route) => false,
                      // );
                    } else {
                      Utils.positiveToastMessage("Please select any one of them");
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}






// import 'package:CoachBot/constants/app_string_constants.dart';
// import 'package:CoachBot/res/component/custom_button.dart';
// import 'package:CoachBot/theme/text_style_util.dart';
// import 'package:CoachBot/utils/routes/route_name.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../res/component/custom_card.dart';
// import '../../utils/utils.dart';
//
// class HealthStatusForm extends StatefulWidget {
//
//   const HealthStatusForm({super.key});
//
//   @override
//   _HealthStatusFormState createState() => _HealthStatusFormState();
// }
//
// class _HealthStatusFormState extends State<HealthStatusForm> {
//   bool _isLoading = false;
//   List<String> selectedHealthIssues = [];
//   String? _selectedDisease;
//   String? errorText;
//
//   Future<void> saveHealthDetails() async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       final healthData = {
//         'email': user!.email,
//         'disease': _selectedDisease,
//       };
//
//       await FirebaseFirestore.instance
//           .collection('UserHealthCollection/HealthData')
//           .doc(user!.uid)
//           .set(healthData);
//     } catch (e) {
//       print(e.toString());
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(AppStrings.yourMedicalCondition),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10.h),
//             Center(
//                 child: Text(
//                   'Select any one to find your health status',
//                   style: MyTextStyle.textStyle22(
//                     fontWeight: FontWeight.w600,
//                   ),
//                 )),
//             SizedBox(height: 30.h),
//             CustomCard(
//                 title: 'Diabetes',
//                 isSelected: _selectedDisease == 'Diabetes',
//                 onTap: () {
//                   setState(() {
//                     _selectedDisease = 'Diabetes';
//                     errorText = null;
//                   });
//                 }),
//             CustomCard(
//                 title: 'Hypercholesterolemia',
//                 isSelected: _selectedDisease == 'Hypercholesterolemia',
//                 onTap: () {
//                   setState(() {
//                     _selectedDisease = 'Hypercholesterolemia';
//                     errorText = null;
//                   });
//                 }),
//             CustomCard(
//                 title: 'Celiac',
//                 isSelected: _selectedDisease == 'Celiac',
//                 onTap: () {
//                   setState(() {
//                     _selectedDisease = 'Celiac';
//                     errorText = null;
//                   });
//                 }),
//             CustomCard(
//                 title: 'Gout',
//                 isSelected: _selectedDisease == 'Gout',
//                 onTap: () {
//                   setState(() {
//                     _selectedDisease = 'Gout';
//                     errorText = null;
//                   });
//                 }),
//             CustomCard(
//                 title: 'None',
//                 isSelected: _selectedDisease == 'None',
//                 onTap: () {
//                   setState(() {
//                     _selectedDisease = 'None';
//                     errorText = null;
//                   });
//                 }),
//             SizedBox(height: 30.h),
//             CustomButton(
//               title: 'Continue',
//               loading: _isLoading,
//               onTap: () {
//                 if (_selectedDisease != null) {
//                   setState(() {
//                     _isLoading = true;
//                   });
//                   saveHealthDetails();
//                   Navigator.pushNamedAndRemoveUntil(
//                     context,
//                     RouteName.BottomNavBar,
//                         (route) => false,
//                   );
//                 } else {
//                   Utils.positiveToastMessage("Please select any one of them");
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
