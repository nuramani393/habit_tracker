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

  bool _showToday = false;
  bool _showWeek = false;
  Color _todayColor = bgColor;
  Color _weeklyColor = bgColor;
  bool _showSummary = false;
  bool _showfolder = false;
  Color _summaryColor = bgColor;
  Color _folderColor = bgColor;

  @override
  void initState() {
    super.initState();
    _showToday = true;
    _showWeek = false;
    _todayColor = darkColor;
    _weeklyColor = midColor;
    _showSummary = true;
    _showfolder = false;
    _summaryColor = darkColor;
    _folderColor = midColor;

    _habitController.getHabits();
    // _habitController.getCompletionPercentages();
    _habitController.getWeekCount();
    _habitController.getWeeklyData();
    // _getHabitListLengthForToday();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            folderbar(),
            SizedBox(height: 20),
            _showProductivity(),
            SizedBox(height: 20),
            if (_showToday) _showHabitListToday(),
            if (_showWeek) _showHabitListWeek(),

            // _showHabitListToday(),
            // _showPercentage(context),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 3),
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
      height: 480,
      child: Obx(() {
        var habitList = _habitController.habitList;
        int completedCount = 0, skippedCount = 0, notDoneCount = 0;
        double completedPercentage = 0,
            skippedPercentage = 0,
            notDonePercentage = 0,
            productivity = 0;

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

        if (habitList.isEmpty) {
          return Center(child: Text("No habits found"));
        } else {
          // Get the habits length for today

          if (_showToday) {
            // Calculate the completion, skipped, and not done counts
            completedCount = habitListForToday
                .where((habit) => habit.isCompleted == 1)
                .length;
            skippedCount =
                habitListForToday.where((habit) => habit.isSkipped == 1).length;
            notDoneCount =
                habitListForToday.length - completedCount - skippedCount;

            completedPercentage =
                (completedCount / habitListForToday.length) * 100;
            skippedPercentage = (skippedCount / habitListForToday.length) * 100;
            notDonePercentage = (notDoneCount / habitListForToday.length) * 100;

            productivity = (completedCount / habitListForToday.length) * 100;
          } else if (_showWeek) {
            var weeklyData = _habitController.weeklyData;
            if (weeklyData.isEmpty) {
              return Center(child: CircularProgressIndicator());
            } else {
              // Calculate the completion, skipped, and not done counts from weekdata
              completedCount =
                  weeklyData.where((habit) => habit['isCompleted'] == 1).length;
              // print("weeklyData completed: $completedCount");
              skippedCount =
                  weeklyData.where((habit) => habit['isSkipped'] == 1).length;
              // print("weeklyData skipped: $skippedCount");

// Calculate the completion, skipped, and not done counts from this day
              int todaycompletedCount = habitListForToday
                  .where((habit) => habit.isCompleted == 1)
                  .length;
              // print("today complete: $todaycompletedCount");
              int todayskippedCount = habitListForToday
                  .where((habit) => habit.isSkipped == 1)
                  .length;
              // print("todayskipped in week: $todayskippedCount");
              int todaynotDoneCount = habitListForToday.length -
                  todaycompletedCount -
                  todayskippedCount;
              // print("todaynotdone in week: $todaynotDoneCount");

              notDoneCount = weeklyData.length -
                  completedCount -
                  skippedCount +
                  todaynotDoneCount;
              // print("notdone in week: $notDoneCount");

              int length = weeklyData.length + todaynotDoneCount;
              // print(
              //     "length: $length = ${weeklyData.length} + $todaynotDoneCount");

              completedPercentage = (completedCount / length) * 100;
              skippedPercentage = (skippedCount / length) * 100;
              notDonePercentage = (notDoneCount / length) * 100;
              productivity = (completedCount / length) * 100;
            }
          }

          return Padding(
            padding: EdgeInsets.fromLTRB(defaultSize, 10, defaultSize, 10),
            child: Container(
              padding: EdgeInsets.only(bottom: 10),
              width: 450,
              height: 300,
              decoration: BoxDecoration(
                color: secondColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20, 30, 0),
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
                  insightListBar(),
                  SizedBox(height: 20),
                  Expanded(
                    child: MyPieChart(
                      completedPercentage: completedPercentage,
                      skippedPercentage: skippedPercentage,
                      notDonePercentage: notDonePercentage,
                      productivity: productivity,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      'Productivity calculate your habit completions percentage',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: black),
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

  Widget _showHabitListToday() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize),
      child: Obx(() {
        var habitList = _habitController.habitList;
        if (habitList.isEmpty) {
          return Center(child: Text("No habits found"));
        } else {
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
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Habit List for Today',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                ),
              ),
              SizedBox(height: 10),
              ...habitListForToday.map((habit) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: habit.isCompleted == 1
                        ? darkColor
                        : habit.isSkipped == 1
                            ? greyColor
                            : midColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        habit.title!
                            .split(' ')
                            .map((word) => word.capitalize)
                            .join(' '),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color:
                                  habit.isCompleted == 1 ? whiteColor : black,
                            ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        'Status: ${habit.isCompleted == 1 ? 'Completed' : habit.isSkipped == 1 ? 'Skipped' : 'To Do'}',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w500,
                              color:
                                  habit.isCompleted == 1 ? whiteColor : black,
                            ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }
      }),
    );
  }

  Widget _showHabitListWeek() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: defaultSize),
      child: Obx(() {
        var weekcount = _habitController.weekcount;
        if (weekcount.isEmpty) {
          return Center(child: Text("No habits found"));
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Habits for This Week',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: black,
                      ),
                ),
              ),
              SizedBox(height: 10),
              ...weekcount.map((habit) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                  decoration: BoxDecoration(
                    color: secondColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        habit['habitName']
                            .toString()
                            .split(' ')
                            .map((word) => word.capitalize)
                            .join(' '),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: black,
                            ),
                      ),
                      // SizedBox(width: 15),
                      Spacer(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: darkColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Completed: ${habit['completed']}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          color: greyColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          'Skipped:  ${habit['skipped']}',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: whiteColor,
                                  ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ],
          );
        }
      }),
    );
  }

  Container insightListBar() {
    return Container(
      decoration: BoxDecoration(
        color: midColor,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 38,
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showToday = true;
                  _showWeek = false;
                  _todayColor = darkColor; // Change color
                  _weeklyColor = midColor; // Reset color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _todayColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: _todayColor == darkColor
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showToday = false;
                  _showWeek = true;
                  _todayColor = midColor; // Change color
                  _weeklyColor = darkColor; // Reset color Change color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _weeklyColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Week',
                    style: TextStyle(
                      color: _weeklyColor == darkColor
                          ? Colors.white
                          : Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container folderbar() {
    return Container(
      decoration: BoxDecoration(
        color: midColor,
        borderRadius: BorderRadius.circular(8),
      ),
      height: 38,
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showSummary = true;
                  _showfolder = false;
                  _summaryColor = darkColor; // Change color
                  _folderColor = midColor; // Reset color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _summaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Summary',
                    style: TextStyle(
                      color: _summaryColor == darkColor
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showSummary = false;
                  _showfolder = true;
                  _summaryColor = midColor; // Reset color
                  _folderColor = darkColor; // Reset color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _folderColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Category',
                    style: TextStyle(
                      color: _folderColor == darkColor
                          ? Colors.white
                          : Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

//
}
