import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/features/core/screens/explore/explore.dart';
import 'package:habit_tracker/src/features/core/screens/habits/AddHabitPage.dart';
import 'package:habit_tracker/src/features/core/screens/insights/insights.dart';
import 'package:habit_tracker/src/features/core/screens/settings/settings.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int selectedIndex;

  CustomBottomNavBar({required this.selectedIndex});

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  late int _selectedIndex;
  final _habitController = Get.put(HabitController());

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  Future<void> _onItemTapped(int index) async {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          Get.offAll(() => Dashboard());
          break;
        case 1:
          Get.to(() => Explore());
          break;
        case 2:
          await Get.to(() => AddHabitPage());
          // Assuming you have a habitController to refresh habits after adding
          _habitController.getHabits();
          break;
        case 3:
          Get.to(() => Insights());
          break;
        case 4:
          Get.off(() => Settings());
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      currentIndex: _selectedIndex,
      selectedItemColor: darkColor, // Make sure you have this color defined
      onTap: _onItemTapped,
      items: <BottomNavigationBarItem>[
        BottomNavBar(Icons.list, 30, 'Habits'),
        BottomNavBar(Icons.explore, 30, 'Explore'),
        BottomNavBar(Icons.add_circle_rounded, 45, 'Add Habit'),
        BottomNavBar(Icons.insights, 30, 'Insights'),
        BottomNavBar(Icons.settings, 30, 'Settings'),
      ],
    );
  }

  BottomNavigationBarItem BottomNavBar(
      IconData iconData, double iconsize, String label) {
    return BottomNavigationBarItem(
      icon: Icon(
        iconData,
        color: Colors.black,
        size: iconsize,
      ),
      label: label,
    );
  }
}
