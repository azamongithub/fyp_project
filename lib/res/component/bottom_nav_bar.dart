import 'package:CoachBot/view/bottom_nav_tabs/ai_trainer_tab.dart';
import 'package:CoachBot/view/bottom_nav_tabs/dashboard.dart';
import 'package:CoachBot/view/bottom_nav_tabs/stats_tab.dart';
import 'package:CoachBot/view/bottom_nav_tabs/plans_tab.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../view/settings/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final screens = [
    Dashboard(),
    PlansTab(),
    StatsTab(),
    AiTrainerTab(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Colors.blue.shade100,
            labelTextStyle: MaterialStateProperty.all(
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
        child: NavigationBar(
          backgroundColor: const Color(0xFFf1f5fb),
          selectedIndex: index,
          onDestinationSelected: (index) => setState(() => this.index = index),
          destinations: const [
            NavigationDestination(
              // icon: Icon(FontAwesomeIcons.houseUser , color: Color(0xff3140b0), size: 20,),
              icon: Icon(Icons.home_outlined, color: Color(0xff3140b0)),
              label: 'Dashboard',
            ),
            NavigationDestination(
              // icon: Icon(
              //   FontAwesomeIcons.dumbbell,
              //   color: Color(0xff3140b0),
              //   size: 20,
              // ),
              icon:
                  Icon(Icons.edit_calendar_outlined, color: Color(0xff3140b0)),
              label: 'My Plans',
            ),
            // NavigationDestination(
            //   icon: Icon(FontAwesomeIcons.utensils , color: Color(0xff3140b0)),
            //   label: 'Meal',
            // ),
            NavigationDestination(
              // icon: Icon(FontAwesomeIcons.chartLine, color: Color(0xff3140b0)),
              icon: Icon(Icons.assessment_outlined , color: Color(0xff3140b0)),

              label: 'Stats',
            ),
            NavigationDestination(
              icon: Icon(FontAwesomeIcons.userAstronaut, color: Color(0xff3140b0)),
              label: 'AI Trainer',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: Color(0xff3140b0)),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
// //
// class BottomNavBar extends StatefulWidget {
//   const BottomNavBar({Key? key}) : super(key: key);
//
//   @override
//   State<BottomNavBar> createState() => _BottomNavBarState();
// }
//
// class _BottomNavBarState extends State<BottomNavBar> {
//   final controller = PersistentTabController(initialIndex: 0);
//
//   List<Widget> _buildScreen() {
//     return [
//       Dashboard(),
//       PlansTab(),
//       StatsTab(),
//       AiTrainerTab(),
//       const SettingsScreen(),
//     ];
//   }
//
//   List<PersistentBottomNavBarItem> _navBarTabs() {
//     return [
//       PersistentBottomNavBarItem(
//         title: ("Dashboard" ),
//           activeColorPrimary: Colors.indigo,
//         icon: const Icon(Icons.home_outlined ,
//             color: Color(0xff3140b0)),
//          // inactiveIcon: const Icon(FontAwesomeIcons.houseUser ,
//          //     color: Colors.white),
//       ),
//       PersistentBottomNavBarItem(
//         title: ("My Plan" ),
//         activeColorPrimary: Colors.indigo,
//         icon: const Icon(Icons.calendar_month_outlined,
//           color: Color(0xff3140b0)),
//         // inactiveIcon: const Icon(FontAwesomeIcons.calendarDays ,
//         //     color: Colors.white),
//       ),
//       PersistentBottomNavBarItem(
//         title: ("My Progress" ),
//         activeColorPrimary: Colors.indigo,
//         icon: const Icon(Icons.bar_chart ,
//             color: Color(0xff3140b0)),
//         // inactiveIcon: const Icon(FontAwesomeIcons.chartLine ,
//         //     color: Colors.white),
//       ),
//       PersistentBottomNavBarItem(
//         title: ("AI Trainer" ),
//         activeColorPrimary: Colors.indigo,
//         icon: const Icon(FontAwesomeIcons.userAstronaut, size: 20,
//             color: Color(0xff3140b0)),
//         // inactiveIcon: const Icon(FontAwesomeIcons.robot ,
//         //     color: Colors.white),
//       ),
//       PersistentBottomNavBarItem(
//         title: ("Profile" ),
//         activeColorPrimary: Colors.indigo,
//         icon: const Icon(Icons.person_outline ,
//             color: Color(0xff3140b0)),
//         // inactiveIcon: const Icon(FontAwesomeIcons.robot ,
//         //     color: Colors.white),
//       ),
//
//
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return PersistentTabView(
//       context,
//       screens: _buildScreen(),
//       items: _navBarTabs(),
//       controller: controller,
//       backgroundColor: Colors.indigo.shade100,
//       //Color(0xFFf1f5fb),
//       decoration: NavBarDecoration(
//         borderRadius: BorderRadius.circular(1),
//       ),
//     );
//   }
// }
//
