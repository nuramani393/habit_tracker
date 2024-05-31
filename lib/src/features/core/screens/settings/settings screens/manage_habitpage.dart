import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/features/core/screens/settings/widgets/listview.dart';

class ManageHabitPage extends StatefulWidget {
  const ManageHabitPage({super.key});

  @override
  State<ManageHabitPage> createState() => _ManageHabitPageState();
}

class _ManageHabitPageState extends State<ManageHabitPage> {
  final _habitController = Get.put(HabitController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          headerManageHabit(context),
          // SizedBox(height: 30),
          _showHabits(),
        ],
      ),
    );
  }

  Padding headerManageHabit(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 15, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before_rounded,
              size: 35,
              color: darkColor,
            ),
          ),
          Expanded(
            child: Text("Manage Habits",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }

  _showHabits() {
    return Expanded(
      child: Obx(() {
        if (_habitController.habitList.isEmpty) {
          // Display message when the habit list is empty
          return Center(
            child: Text(
              "You don't have any habits yet",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: _habitController.habitList.length,
            itemBuilder: (_, index) {
              print(_habitController.habitList.length);
              return ListTileWidget(
                title: _habitController.habitList[index].title.toString(),
                trailingIcon: Icons.delete,
                onTrailingIconTap: () {
                  _showDeleteConfirmationDialog(
                      context, _habitController.habitList[index]);
                  // _habitController.delete(_habitController.habitList[index]);
                  // _habitController.getHabits();
                },
              );
            },
          );
        }
      }),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, Habit habit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            "Confirm Deletion",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          content: Text(
            "Are you sure you want to delete this habit?",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w200),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: darkColor)),
              onPressed: () {
                Get.back(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: darkColor)),
              onPressed: () {
                _habitController.delete(habit);
                Get.back(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
