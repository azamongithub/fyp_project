import 'package:CoachBot/notifications_services/notifications_services.dart';
import 'package:CoachBot/view/nutrition_info/nutrition_info_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}


class _DashboardState extends State<Dashboard> {
NotificationServices notificationServices = NotificationServices();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationServices.requestNotificationPermission();
    notificationServices.getDeviceToken().then((value){
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
      if (kDebugMode) {
        print('device token');
      }
      if (kDebugMode) {
        print(value);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Welcome to CoachBot Fitness App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Fitness Goals',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Progress towards your fitness goals'),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('75% Completed'),
                          ElevatedButton(
                            onPressed: () {
                              // Action to view or edit fitness goals
                            },
                            child: const Text('View Goals'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recommended Workouts',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Discover workouts tailored to your goals'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // Action to view recommended workouts
                        },
                        child: const Text('View Workouts'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nutrition',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text('Find nutrition facts of any Item'),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NutritionDataScreen()),
                          );
                        },
                        child: const Text('Nutrition Facts'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




// import 'package:firebase_project/res/component/drawer.dart';
// import 'package:flutter/material.dart';
//
// class MyPlanTab extends StatefulWidget {
//   static const String id = 'home_screen';
//   static const String id2 = 'schedule';
//   const MyPlanTab({Key? key}) : super(key: key);
//
//   @override
//   State<MyPlanTab> createState() => _MyPlanTabState();
// }
//
// class _MyPlanTabState extends State<MyPlanTab> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//        title: const Text('Home'),
//       ),
//       drawer: const AppDrawer(),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         //crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//
//           const Center(
//             child: Text('This is a Home Screen'),
//           ),
//
//           Center(
//             child: TextButton(
//               onPressed: (){
//                 Navigator.pushNamed(context,MyPlanTab.id2);
//               },
//               child: const Text('Go to Schedule'),
//
//             ),
//
//           )
//         ],
//       ),
//
//     );
//   }
// }
