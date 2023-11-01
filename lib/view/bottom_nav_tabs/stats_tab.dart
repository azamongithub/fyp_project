import 'package:flutter/material.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({super.key});

  @override
  _StatsTabState createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> with TickerProviderStateMixin {
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
        title: const Text('Progress Tracking'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white, // Set text color of selected tab
            unselectedLabelColor: Colors.black, // Set text color of unselected tab
            indicator: const BoxDecoration(
              color: Colors.black, // Set background color of selected tab
            ),
            tabs: const [
              Tab(text: 'Workouts'),
              Tab(text: 'Measurements'),
              Tab(text: 'Photos'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildWorkoutsTab(),
                _buildMeasurementsTab(),
                _buildPhotosTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutsTab() {
    return const Center(
      child: Text('Workouts Tab'),
    );
  }

  Widget _buildMeasurementsTab() {
    return const Center(
      child: Text('Measurements Tab'),
    );
  }

  Widget _buildPhotosTab() {
    return const Center(
      child: Text('Photos Tab'),
    );
  }
}
