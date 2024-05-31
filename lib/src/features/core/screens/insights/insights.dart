import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/common_widgets/bottomNavBarWidget.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/features/core/screens/insights/completionPercent.dart';
import 'package:habit_tracker/src/features/core/screens/insights/piechart.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';

class Insights extends StatefulWidget {
  const Insights({super.key});

  @override
  State<Insights> createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  final HabitController _habitController = Get.put(HabitController());

  @override
  void initState() {
    super.initState();
    _habitController.getHabits();
    _habitController.getCompletionPercentages();
    // _getHabitListLengthForToday();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          SizedBox(height: 20),
          _showProductivity(),
          // Expanded(child: MyPieChart()),
          // _showPercentage(context),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
    );
  }

  Padding _showPercentage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(() {
        if (_habitController.completionPercentages.isEmpty) {
          print(_habitController.completionPercentages);
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildCompletionPercentageChart(context);
        }
      }),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor,
      elevation: 0, // Remove elevation
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(top: 30), // Adjust top padding
        child: Text(
          "Insights",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }

  Widget _buildCompletionPercentageChart(BuildContext context) {
    return ListView(
      children: [
        // SizedBox(height: 16),
        Text(
          "Completion Percentages",
          style: Theme.of(context).textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 16),
        CompletionPercentage(
          data: _habitController.completionPercentages,
        ),
      ],
    );
  }

  Widget _showProductivity() {
    return Container(
      height: 410,
      child: Obx(() {
        var habitList = _habitController.habitList;
        if (habitList.isEmpty) {
          return Center(child: Text("No habits found"));
        } else {
          // Get the habits length for today
          List<Habit> habitListForToday = [];
          DateTime now = DateTime.now();
          int weekday = now.weekday;

          for (var habit in habitList) {
            if (habit.repeat == 'Daily') {
              habitListForToday.add(habit);
            } else if (habit.repeat == 'Weekly' &&
                createDateTimeObject(habit.date!).weekday == weekday) {
              habitListForToday.add(habit);
            }
          }

          // Calculate the completion, skipped, and not done counts
          int completedCount =
              habitListForToday.where((habit) => habit.isCompleted == 1).length;
          int skippedCount =
              habitListForToday.where((habit) => habit.isSkipped == 1).length;
          int notDoneCount =
              habitListForToday.length - completedCount - skippedCount;

          // Calculate percentages
          double completedPercentage =
              (completedCount / habitListForToday.length) * 100;
          double skippedPercentage =
              (skippedCount / habitListForToday.length) * 100;
          double notDonePercentage =
              (notDoneCount / habitListForToday.length) * 100;

          // Calculate productivity
          double productivity =
              (completedCount / habitListForToday.length) * 100;

          return Padding(
            padding:
                EdgeInsets.only(top: 20, left: defaultSize, right: defaultSize),
            child: Container(
              width: 450,
              height: 300,
              decoration: BoxDecoration(
                color: midColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 30, 30, 0),
                    child: Center(
                      child: Text(
                        'Productivity',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: MyPieChart(
                      completedPercentage: completedPercentage,
                      skippedPercentage: skippedPercentage,
                      notDonePercentage: notDonePercentage,
                      productivity: productivity,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
