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

    //to calculate streaks
    updateStreaks();
    getHabits();
  }

//only occur when the new habit is added
//update the first time entry of habit_completion table and update the habit status
  Future<void> updateHabitCompletion(
      int habitId, String lastUpdated, bool isCompleted, bool isSkipped) async {
    await DBHelper.updateHabitCompletion(
        habitId, lastUpdated, isCompleted, isSkipped);
    await DBHelper.updateHabitStatus(
        habitId, lastUpdated, isCompleted, isSkipped);
    updateStreaks();
    getHabits();
  }

  void updateHabit(
      int id, String desc, String category, String time, int remind) async {
    await DBHelper.updateHabit(id, desc, category, time, remind);
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
  var weeklyData = <Map<String, dynamic>>[].obs;
  Future<void> getWeeklyData() async {
    // Get today's date
    DateTime now = DateTime.now();

    // Calculate the start and end dates of the current week
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Format the dates to match the format of the `lastUpdated` field
    String startOfWeekFormatted = convertDateTimeToString(startOfWeek);
    String endOfWeekFormatted = convertDateTimeToString(endOfWeek);

    // Query the habit_completion table for entries within the current week
    List<Map<String, dynamic>> data = await DBHelper.getHabitCompletionForWeek(
        startOfWeekFormatted, endOfWeekFormatted);

    weeklyData.value = data;
    print('weeklyData: $weeklyData');
  }

  var weekcount = <Map<String, dynamic>>[].obs;
  void getWeekCount() async {
    // Get today's date
    DateTime now = DateTime.now();

    // Calculate the start and end dates of the current week
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Format the dates to match the format of the `lastUpdated` field
    String startOfWeekFormatted = convertDateTimeToString(startOfWeek);
    String endOfWeekFormatted = convertDateTimeToString(endOfWeek);

    // Query the habit_completion table for entries within the current week
    List<Map<String, dynamic>> data = await DBHelper.getHabitInsightsForWeek(
        startOfWeekFormatted, endOfWeekFormatted);

    weekcount.assignAll(data);
    print('weekcount: $weekcount');
  }

  var weekfolder = <Map<String, dynamic>>[].obs;
  void getWeekfolder() async {
    // Get today's date
    DateTime now = DateTime.now();

    // Calculate the start and end dates of the current week
    DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    DateTime endOfWeek = startOfWeek.add(Duration(days: 6));

    // Format the dates to match the format of the `lastUpdated` field
    String startOfWeekFormatted = convertDateTimeToString(startOfWeek);
    String endOfWeekFormatted = convertDateTimeToString(endOfWeek);

    // Query the habit_completion table for entries within the current week
    List<Map<String, dynamic>> data =
        await DBHelper.getCategoryHabitInsightsForWeek(
            startOfWeekFormatted, endOfWeekFormatted);

    weekfolder.assignAll(data);
    print('weekcount: $weekfolder');
  }
  //
}
