import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/features/core/screens/settings/settings%20screens/manage_habitpage.dart';
import 'package:habit_tracker/src/features/core/screens/settings/widgets/listview.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final habitController = Get.put(HabitController());
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.offAll(() => Dashboard());
                  },
                  icon: Icon(
                    Icons.navigate_before_rounded,
                    size: 35,
                    color: darkColor,
                  ),
                ),
                Expanded(
                  child: Text("Settings",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge),
                ),
                SizedBox(width: 40),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    print('Account tapped');
                  },
                  child: ListTileWidget(
                    title: "Account",
                    leadingIcon: Icons.account_circle_rounded,
                    trailingIcon: Icons.navigate_next_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ManageHabitPage());
                    habitController.getHabits();
                  },
                  child: ListTileWidget(
                    title: "Manage Habits",
                    leadingIcon: Icons.layers_rounded,
                    trailingIcon: Icons.navigate_next_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Account tapped');
                  },
                  child: ListTileWidget(
                    title: "Notifications",
                    leadingIcon: Icons.circle_notifications_rounded,
                    trailingIcon: Icons.navigate_next_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Account tapped');
                  },
                  child: ListTileWidget(
                    title: "Appearance",
                    leadingIcon: Icons.contrast,
                    trailingIcon: Icons.navigate_next_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    print('Account tapped');
                  },
                  child: ListTileWidget(
                    title: "Sign Out",
                    leadingIcon: Icons.login_outlined,
                    trailingIcon: Icons.navigate_next_rounded,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
