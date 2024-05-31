import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/common_widgets/bottomNavBarWidget.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/features/core/screens/habits/habitCompletion.dart';
import 'package:habit_tracker/src/features/core/screens/habits/habit_tile_widget.dart';
import 'package:habit_tracker/src/features/core/screens/quotes/quotes.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime _selectedDate = DateTime.now();

  final _habitController = Get.put(HabitController());

  // var notifyHelper;

  //store width and height of screen
  double width = 0.0;
  double height = 0.0;

  bool _showTodos = false;
  bool _showCompleted = false;
  bool _showSkipped = false;
  Color _todosColor = midColor; // Initial colors
  Color _completedColor = midColor; // Initial colors
  Color _skippedColor = midColor; // Initial colors

  void _onDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  void initState() {
    super.initState();
    // Set _showTodos to true and the other flags to false initially
    _showTodos = true;
    _showCompleted = false;
    _showSkipped = false;
    _todosColor = darkColor;
    _completedColor = midColor;
    _skippedColor = midColor;
    _habitController.updateStreaks();
    _habitController.resetHabitStatus();
    _habitController.getHabits();
    // notifyHelper = NotifyHelper();
    // notifyHelper.initializeNotification();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: Appbar(context),
      body: Column(
        children: [
          DateBar(context),
          const SizedBox(height: 15),
          //
          habitListBar(),
          const SizedBox(height: 30),
          _showHabits(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedIndex: 0),
    );
  }

  _showHabits() {
    if (_selectedDate.year == DateTime.now().year &&
        _selectedDate.month == DateTime.now().month &&
        _selectedDate.day == DateTime.now().day) {
      return Expanded(
        child: Obx(() {
          var habitList = _habitController.habitList;
          // print('Printing habitList:');
          // habitList.forEach((habit) {
          //   print(habit.toJson());
          // });
          if (habitList.isEmpty) {
            return displayNoHabit(context: context);
          } else {
            List<Habit> filteredHabits = habitList.where((habit) {
              if (_showTodos) {
                return habit.isCompleted == 0 && habit.isSkipped == 0;
              } else if (_showCompleted) {
                return habit.isCompleted == 1;
              } else {
                return habit.isSkipped == 1;
              }
            }).toList();

            // Debugging: Print the number of filtered habits and their titles
            // print('Filtered habits count: ${filteredHabits.length}');
            // filteredHabits.forEach((habit) {
            //   print(
            //       'Habit title: ${habit.title}, isCompleted: ${habit.isCompleted}');
            // });
            return ListView.builder(
              itemCount: filteredHabits.length,
              itemBuilder: (_, index) {
                Habit habit = filteredHabits[index];

                bool isMatchedDate = false;
                if (habit.repeat == "Daily") {
                  isMatchedDate = true;
                } else if (habit.repeat == "Weekly") {
                  isMatchedDate = createDateTimeObject(habit.date!).weekday ==
                      _selectedDate.weekday;
                }

                if (isMatchedDate) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(HabitCompletion(
                        habit: habit,
                        selectedDate: _selectedDate,
                      ));
                      print(_selectedDate);
                    },
                    child: HabitTile(habit),
                  );
                } else {
                  return Container();
                }
              },
            );
          }
        }),
      );
    } else {
      return _showAllHabits();
    }
  }

  _showAllHabits() {
    return Expanded(
      child: Obx(() {
        var habitList = _habitController.habitList;
        if (habitList.isEmpty) {
          return displayNoHabit(context: context);
        } else {
          if (_showTodos) {
            return ListView.builder(
              itemCount: habitList.length,
              itemBuilder: (_, index) {
                Habit habit = habitList[index];
                // print(habitList.length);
                return _buildHabitTile(habit);
              },
            );
          } else if (_showCompleted) {
            return Center(
              child: Text(
                "You haven't completed any habits on this day.",
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Center(
              child: Text(
                "Congrats! You haven't skipped any habits yet!",
                style: Theme.of(context).textTheme.labelSmall,
                textAlign: TextAlign.center,
              ),
            );
          }
        }
      }),
    );
  }

  Widget _buildHabitTile(Habit habit) {
    DateTime? habitDate =
        habit.date != null ? createDateTimeObject(habit.date!) : null;
    bool isMatchedDate = false;

    if (habit.repeat == "Daily") {
      isMatchedDate = true;
    } else if (habit.repeat == "Weekly" && habitDate != null) {
      isMatchedDate = habitDate.weekday == _selectedDate.weekday;
    } else if (habit.repeat == "Monthly" && habitDate != null) {
      isMatchedDate = habitDate.day == _selectedDate.day;
    }

    if (isMatchedDate) {
      return GestureDetector(
        onTap: () {
          Get.to(HabitCompletion(
            habit: habit,
            selectedDate: _selectedDate,
          ));
        },
        child: HabitTile(habit),
      );
    }
    return Container();
  }

  ///
  //

  Container habitListBar() {
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
                  _showTodos = true;
                  _showCompleted = false;
                  _showSkipped = false;
                  _todosColor = darkColor; // Change color
                  _completedColor = midColor; // Reset color
                  _skippedColor = midColor; // Reset color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _todosColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'To-Dos',
                    style: TextStyle(
                      color: _todosColor == darkColor
                          ? Colors.white
                          : Colors.black,
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
                  _showTodos = false;
                  _showCompleted = true;
                  _showSkipped = false;
                  _todosColor = midColor; // Reset color
                  _completedColor = darkColor; // Reset color
                  _skippedColor = midColor; // Change color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _completedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Completed',
                    style: TextStyle(
                      color: _completedColor == darkColor
                          ? Colors.white
                          : Colors.black,
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
                  _showTodos = false;
                  _showCompleted = false;
                  _showSkipped = true;
                  _todosColor = midColor; // Reset color
                  _completedColor = midColor; // Reset color
                  _skippedColor = darkColor; // Change color
                });
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _skippedColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Skipped',
                    style: TextStyle(
                      color: _skippedColor == darkColor
                          ? Colors.white
                          : Colors.black,
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

  Container DateBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 53,
        initialSelectedDate: DateTime.now(),
        selectionColor: whiteColor,
        selectedTextColor: darkColor,
        // dateTextStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 20,)?? TextStyle(),
        dateTextStyle: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600) ??
            TextStyle(),
        monthTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: black, fontWeight: FontWeight.w400) ??
            TextStyle(),
        dayTextStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: black, fontWeight: FontWeight.w600) ??
            TextStyle(),
        onDateChange: _onDateChanged,
      ),
    );
  }

  AppBar Appbar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.to(() => QuotesList()),
        child: const Icon(
          Icons.format_list_bulleted_outlined,
          size: 25,
        ),
      ),

      //title will be adjusted accoridng to the date picked by user
      title: Text(
        // _selectedDate.isAtSameMomentAs(DateTime.now())
        _selectedDate.year == DateTime.now().year &&
                _selectedDate.month == DateTime.now().month &&
                _selectedDate.day == DateTime.now().day
            ? 'Today'
            : DateFormat.MMMMd().format(_selectedDate),
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.w800),
        // '${currentDateTime.day} ' +
        //     date_util.DateUtils.months[currentDateTime.month - 1],
        // style: Theme.of(context).textTheme.titleLarge
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: bgColor,
    );
  }
}

class displayNoHabit extends StatelessWidget {
  const displayNoHabit({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "You don't have any habit yet.\nTap the + icon to create your first\nhabit!",
        style: Theme.of(context).textTheme.labelSmall,
        textAlign: TextAlign.center,
      ),
    );
  }
}
