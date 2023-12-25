import 'package:CoachBot/modules/health_status/view/health_status_details/health_details_screen.dart';
import 'package:CoachBot/modules/profile/view/profile_details/profile_details.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import '../../../../theme/text_style_util.dart';
import '../../../fitness/view/fitness_details/fitness_details.dart';
import '../../../health_status/view/health_status_details/health_details_screen.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});
  @override
  _ProfileDetailsScreenState createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: Text('Profile', style: CustomTextStyle.appBarStyle()),
        backgroundColor: AppColors.themeColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  const PersonalDetails(),
                  const FitnessDetails(),
                  //const HealthDetails(),
                  HealthDetailsScreen(),



                ],
              ),
            ),
            TabBar(
              dividerColor: Colors.green,
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: const BoxDecoration(
                color: AppColors.themeColor,
              ),
              tabs: const [
                Tab(text: 'Personal'),
                Tab(text: 'Fitness'),
                Tab(text: 'Health'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
