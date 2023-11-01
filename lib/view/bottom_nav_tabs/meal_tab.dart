import 'package:CoachBot/res/component/drawer.dart';
import 'package:flutter/material.dart';

class MealTab extends StatefulWidget {
  @override
  _MealTabState createState() => _MealTabState();
}

class _MealTabState extends State<MealTab> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('Nutrition'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: _tabController,
            labelColor: Colors.white, // Set text color of selected tab
            unselectedLabelColor: Colors.black, // Set text color of unselected tab
            indicator: BoxDecoration(
              color: Colors.black, // Set background color of selected tab
            ),
            tabs: [
              Tab(text: 'Meal Plans'),
              Tab(text: 'Recipes'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMealPlansTab(),
                _buildRecipesTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealPlansTab() {
    return Center(
      child: Text('Meal Plans Tab'),
    );
  }

  Widget _buildRecipesTab() {
    return Center(
      child: Text('Recipes Tab'),
    );
  }
}
