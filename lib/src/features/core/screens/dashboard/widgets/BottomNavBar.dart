import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool showUnselectedLabels;
  final Color selectedItemColor;
  final List<BottomNavigationBarItem> items;

  MyBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.showUnselectedLabels,
    required this.selectedItemColor,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      selectedItemColor: Colors.black, // You can customize this if needed
      onTap: onTap,
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
        color: black,
        size: iconsize,
      ),
      label: label,
    );
  }
}
