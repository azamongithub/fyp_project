import 'package:CoachBot/constants/app_string_constants.dart';
import 'package:CoachBot/theme/color_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../modules/dashboard/view/dashboard_screen.dart';
import '../modules/my_plans/view/plans_tab.dart';
import '../modules/settings/view/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int index = 0;
  final screens = [
    const DashboardScreen(),
    PlansTab(),
    const SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // onWillPop: () async {
      //   return true;
      // },
      child: Scaffold(
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
          data: NavigationBarThemeData(
              indicatorColor: Colors.blue.shade200,
              labelTextStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          child: NavigationBar(
            backgroundColor: const Color(0xFFf1f5fb),
            selectedIndex: index,
            onDestinationSelected: (index) =>
                setState(() => this.index = index),
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined,
                    color: ColorUtil.themeColor, size: 30.sp),
                selectedIcon: Icon(Icons.home_outlined,
                    color: ColorUtil.themeColor, size: 35.sp),
                label: AppStrings.dashboard,
                //selectedIcon: Icon(Icons.home_outlined, color: Color(0xff3140b0)),
              ),
              NavigationDestination(
                icon: Icon(Icons.edit_calendar_outlined,
                    color: ColorUtil.themeColor, size: 25.sp),
                selectedIcon: Icon(Icons.edit_calendar_outlined,
                    color: ColorUtil.themeColor, size: 30.sp),
                label: AppStrings.myPlans,
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined,
                    color: ColorUtil.themeColor, size: 30.sp),
                selectedIcon: Icon(Icons.settings_outlined,
                    color: ColorUtil.themeColor, size: 35.sp),
                label: AppStrings.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}