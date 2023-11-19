import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/meal_plan_model.dart';

class DisplayMealPlansScreen extends StatefulWidget {
  @override
  _DisplayMealPlansScreenState createState() => _DisplayMealPlansScreenState();
}

class _DisplayMealPlansScreenState extends State<DisplayMealPlansScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late List<MealPlanModel> mealPlans;

  @override
  void initState() {
    super.initState();
    fetchMealPlans();
  }

  Future<void> fetchMealPlans() async {
    try {
      QuerySnapshot querySnapshot =
      await _firestore.collection('meal_plans').get();

      mealPlans = querySnapshot.docs
          .map((DocumentSnapshot doc) =>
          MealPlanModel.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();

      // Force a rebuild of the UI after fetching the data
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      print('Error fetching meal plans: $e');
      // Handle the error appropriately (e.g., show an error message to the user)
    }
  }

  void navigateToDetailPage(String mealPlanId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealPlanDetailScreen(mealPlanId: mealPlanId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plans'),
      ),
      body: mealPlans != null
          ? ListView.builder(
        itemCount: mealPlans.length,
        itemBuilder: (context, index) {
          MealPlanModel mealPlan = mealPlans[index];

          // Customize how you want to display the meal plan data
          return ListTile(
            title: Text('ID: ${mealPlan.id}'),
            subtitle: Text(
                'Type: ${mealPlan.type}\nCalories: ${mealPlan.totalCalories}'),
            onTap: () {
              // Navigate to the detail page when a meal plan is tapped
              navigateToDetailPage(mealPlan.id);
            },
          );
        },
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class MealPlanDetailScreen extends StatelessWidget {
  final String mealPlanId;

  MealPlanDetailScreen({required this.mealPlanId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Plan Detail'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('meal_plans').doc(mealPlanId).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No data found for Meal Plan ID: $mealPlanId'));
          }

          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          MealPlanModel mealPlan = MealPlanModel.fromJson(mealPlanId, data);

          return ListView(
            children: [
              ListTile(
                title: Text('ID: ${mealPlan.id}'),
                subtitle: Text('Type: ${mealPlan.type}\nCalories: ${mealPlan.totalCalories}'),
              ),
              for (var dayEntry in mealPlan.days.entries)
                ListTile(
                  title: Text('Day ${dayEntry.key}'),
                  subtitle: Text(
                    'Breakfast: ${dayEntry.value['breakfast']?['title1'] ?? ""}\n'
                        'Lunch: ${dayEntry.value['lunch']?['title1'] ?? ""}\n'
                        'Dinner: ${dayEntry.value['dinner']?['title1'] ?? ""}',
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}