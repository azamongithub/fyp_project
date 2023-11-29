import 'package:CoachBot/res/color.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/fitness_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/health_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details.dart';
import 'package:flutter/material.dart';
import '../../../theme/text_style_util.dart';

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
        title: Text('Profile', style: MyTextStyle.appBarStyle()),
        backgroundColor: ColorUtil.themeColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  PersonalDetails(),
                  FitnessDetails(),
                  HealthDetails(),
                ],
              ),
            ),
            TabBar(
              dividerColor: Colors.green,
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: ColorUtil.themeColor,
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
