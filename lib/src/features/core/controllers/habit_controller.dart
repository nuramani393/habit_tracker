import 'package:get/get.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';
import 'package:habit_tracker/src/features/core/db/db_helper.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'dart:async';

class HabitController extends GetxController {
  var habitList = <Habit>[].obs;

  void getHabits() async {
    List<Map<String, dynamic>> habits = await DBHelper.query();
    // print('Fetched habits: $habits'); // Debug print
    habitList.assignAll(habits.map((data) => Habit.fromJson(data)).toList());
  }

// will add new habit data and initializing data habit_completion table
  Future<int> addHabit({required Habit habit}) async {
    int habitId = await DBHelper.insert(habit);
    await addHabitCompletion(
        habitId, todaysDateFormatted(), false, false); // Initial entry
    return habitId;
  }

//adding habit completion data to habit_completion table
  Future<void> addHabitCompletion(
      int habitId, String date, bool completed, bool skipped) async {
    await DBHelper.addHabitCompletion(habitId, date, completed, skipped);
  }

//add new table of habit_completion for another date entry and update the habit status
  Future<void> moreHabitCompletion(
      int habitId, String date, bool isCompleted, bool isSkipped) async {
    await DBHelper.addHabitCompletion(habitId, date, isCompleted, isSkipped);
    await DBHelper.updateHabitStatus(habitId, date, isCompleted, isSkipped);

    //wanted to update the streaks of the current habit
    getStreak(habitId);
    getHabits();
  }

//only occur when the new habit is added
//update the first time entry of habit_completion table and update the habit status
  void updateHabitCompletion(
      int habitId, String lastUpdated, bool isCompleted, bool isSkipped) async {
    await DBHelper.updateHabitCompletion(
        habitId, lastUpdated, isCompleted, isSkipped);
    await DBHelper.updateHabitStatus(
        habitId, lastUpdated, isCompleted, isSkipped);
    getStreak(habitId);
    getHabits();
  }

//to reset all the habit status in Habits table if lastUpdated is not today
  void resetHabitStatus() async {
    await DBHelper.resetHabitStatus();
    getHabits();
  }

//to get the streaks of the habits
  void updateStreaks() async {
    await DBHelper.updateStreaks();
    print("outside upstreaks but controller");
    getHabits();
  }

  //to update the streaks of the current habit
  Future<int> getStreak(int habitId) async {
    return await DBHelper.updateStreak(habitId);
    // getHabits();
  }

  //to reset the streaks of the current habit
  void resetStreak(int habitId) async {
    await DBHelper.resetStreak(habitId);
    print("streaks is resetted");
    getHabits();
  }

  //to remove habits from Habits table and habit_completion table
  void delete(Habit habit) async {
    await DBHelper.deleteHabitAndCompletions(habit.id!);
    getHabits();
  }

//to fetch the updated streaks of the current habit
  Future<int> fetchStreak(int habitId) async {
    // Fetch the latest streak from the database or API
    return await DBHelper.fetchStreak(habitId);
  }

//to return percentage of completions for the habits
  var completionPercentages = <Map<String, dynamic>>[].obs;
  void getCompletionPercentages() async {
    // print("inisde getCompletionPercentages");
    List<Map<String, dynamic>> percentages =
        await DBHelper.getCompletionPercentages();
    completionPercentages.assignAll(percentages);
  }

//to count productivity for today

  // Future<int> getHabitListLengthForToday() async {
  //   // String todayDate = todaysDateFormatted();
  //   getHabits();
  //   List<Habit> habitListForToday = [];
  //   print('Length of habitList: ${habitList.length}');
  //   for (var habit in habitList) {
  //     if (habit.repeat == 'Daily') {
  //       habitListForToday.add(habit);
  //     } else if (habit.repeat == 'Weekly') {
  //       DateTime now = DateTime.now();
  //       int weekday = now.weekday;

  //       if (createDateTimeObject(habit.date!).weekday == weekday) {
  //         habitListForToday.add(habit);
  //       } else {
  //         print("Weekly habit '${habit.title}' does not match today's weekday");
  //       }
  //     } else {
  //       print(
  //           "Unknown repetition type for habit '${habit.title}': ${habit.repeat}");
  //     }
  //   }
  //   print("habit length is  ${habitListForToday.length}");
  //   return Future.value(habitListForToday.length);
  // }
}
