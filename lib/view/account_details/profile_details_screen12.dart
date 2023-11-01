import 'package:CoachBot/view/account_details/profile_details_tabs/fitness_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/health_details.dart';
import 'package:CoachBot/view/account_details/profile_details_tabs/profile_details.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen12 extends StatefulWidget {
  const ProfileDetailsScreen12({super.key});

  @override
  _ProfileDetailsScreen12State createState() => _ProfileDetailsScreen12State();
}

class _ProfileDetailsScreen12State extends State<ProfileDetailsScreen12> with TickerProviderStateMixin {
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
        title: const Text('Profile'),
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
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              indicator: BoxDecoration(
                color: const Color(0xff3140b0).withOpacity(1),
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

  // Widget ProfileTab() {
  //   return Center(
  //     child: Text('Profile Tab'),
  //   );
  // }
  //
  // Widget _buildMeasurementsTab() {
  //   return Center(
  //     child: Text('Measurements Tab'),
  //   );
  // }
  //
  // Widget _buildPhotosTab() {
  //   return Center(
  //     child: Text('Photos Tab'),
  //   );
  // }
}
