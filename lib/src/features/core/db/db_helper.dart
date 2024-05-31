import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "Habits";

  Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String databasesPath = await getDatabasesPath();
      print("Database path: $databasesPath");
      String dbPath = join(databasesPath, 'Habits.db');
      _db = await openDatabase(dbPath, version: _version, onCreate: _onCreate);
    } catch (e) {
      print(e);
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      "CREATE TABLE $_tableName("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "title TEXT, "
      "desc TEXT,"
      "category TEXT, "
      "date STRING,"
      "lastUpdated STRING,"
      "time STRING, "
      "remind INTEGER, "
      "streaks INTEGER, "
      "isCompleted INTEGER, "
      "isSkipped INTEGER, "
      "repeat TEXT)",
    );
    await db.execute('''
      CREATE TABLE habit_completion (
        id INTEGER PRIMARY KEY,
        habitId INTEGER,
        lastUpdated STRING,
        isCompleted INTEGER,
        isSkipped INTEGER,
        FOREIGN KEY(habitId) REFERENCES $_tableName(id)
      )
    ''');
  }

//insert habit data into json
  static Future<List<Map<String, dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

//to insert new habits into Habits table
  static Future<int> insert(Habit habit) async {
    print("insert function called");
    // print('Inserting habit: ${habit.toJson()}');
    return await _db!.insert(_tableName, habit.toJson());
  }

//add new entry of habit_completion
  static Future<int> addHabitCompletion(
      int habitId, String date, bool completed, bool skipped) async {
    return await _db!.insert('habit_completion', {
      'habitId': habitId,
      'lastUpdated': date,
      'isCompleted': completed ? 1 : 0,
      'isSkipped': skipped ? 1 : 0,
    });
  }

//to update the first initial entry of habit_completion table
  static Future<int> updateHabitCompletion(
      int habitId, String date, bool completed, bool skipped) async {
    final int completedValue = completed ? 1 : 0;
    final int skippedValue = skipped ? 1 : 0;

    return await _db!.rawUpdate('''
      UPDATE habit_completion
      SET isCompleted = ?, isSkipped = ?
      WHERE habitId = ? AND lastUpdated = ?
    ''', [completedValue, skippedValue, habitId, date]);
  }

//to update habit status in Habits table accorrding to the latest values in habit_completion
  static Future<int> updateHabitStatus(
      int habitId, String lastUpdated, bool isCompleted, bool isSkipped) async {
    final int completedValue = isCompleted ? 1 : 0;
    final int skippedValue = isSkipped ? 1 : 0;

    return await _db!.update(
      'Habits',
      {
        'isCompleted': completedValue,
        'isSkipped': skippedValue,
        'lastUpdated': lastUpdated.toString(),
      },
      where: 'id = ?',
      whereArgs: [habitId],
    );
  }

//to reset all the habit status in Habits table if lastUpdated is not today
  static Future<void> resetHabitStatus() async {
    // Get all habits from the Habits table
    List<Map<String, dynamic>> habits = await _db!.query('Habits');

    // Get today's date
    int today = int.parse(todaysDateFormatted());
    String todays = todaysDateFormatted();

    for (var habit in habits) {
      // Get the lastUpdated date of the Habits table
      String toint = habit['lastUpdated'].toString();
      int lastUpdated = int.parse(toint);

      // Check if the lastUpdated date is not the same as today's date
      if (lastUpdated < today) {
        // Reset isCompleted and isSkipped properties to 0
        await _db!.update(
          'Habits',
          {'isCompleted': 0, 'isSkipped': 0},
          where: 'id = ?',
          whereArgs: [habit['id']],
        );
      } else if (lastUpdated == today) {
        //  Fetch habit completions for today
        List<Map<String, dynamic>> habitCompletion = await _db!.query(
          'habit_completion',
          where: 'habitId = ? AND lastUpdated = ?',
          whereArgs: [habit['id'], todays],
        );
        if (habitCompletion.isNotEmpty) {
          // Since we expect only one completion entry, take the first one
          Map<String, dynamic> habitCompletions = habitCompletion[0];

          // Extract completion data
          int isCompleted = habitCompletions['isCompleted'];
          int isSkipped = habitCompletions['isSkipped'];

          // Update Habits table with completion data for today
          await _db!.update(
            'Habits',
            {'isCompleted': isCompleted, 'isSkipped': isSkipped},
            where: 'id = ?',
            whereArgs: [habit['id']],
          );
        }
      } else if (lastUpdated > today) {
        //use proprty of lastUpdated
        print(
            'Habit ID ${habit['id']} is already up-to-date with properties: isCompleted=${habit['isCompleted']}, isSkipped=${habit['isSkipped']}');
      }
    }
  }

  //to remove habits from Habits table and habit_completion table
  static Future<int> deleteHabitAndCompletions(int habitId) async {
    // Start a transaction to ensure both deletions happen together
    return await _db!.transaction((txn) async {
      await txn.delete(
        'habit_completion',
        where: 'habitId = ?',
        whereArgs: [habitId],
      );

      return await txn.delete(
        _tableName,
        where: 'id = ?',
        whereArgs: [habitId],
      );
    });
  }

//to update the streak count of all habits
  static Future<void> updateStreaks() async {
    // Get all habits from the Habits table
    List<Map<String, dynamic>> habits = await _db!.query('Habits');

    // Separate the habits into daily and weekly
    List<Map<String, dynamic>> dailyHabits =
        habits.where((habit) => habit['repeat'] == 'Daily').toList();
    List<Map<String, dynamic>> weeklyHabits =
        habits.where((habit) => habit['repeat'] == 'Weekly').toList();

    print("calling daily streaks");
    // Update streaks for daily habits
    await _updateDailyStreaks(dailyHabits);

    print("calling weekly streaks");
    // Update streaks for weekly habits
    await _updateWeeklyStreaks(weeklyHabits);
  }

//to update all the streaks for daily habits
  static Future<void> _updateDailyStreaks(
      List<Map<String, dynamic>> habits) async {
    print("inside daily streaks");
    for (var habit in habits) {
      print("Processing daily habit: ${habit['title']}");
      List<Map<String, dynamic>> completions = await _db!.query(
        'habit_completion',
        where: 'habitId = ?',
        whereArgs: [habit['id']],
        orderBy: 'lastUpdated DESC',
      );

      if (completions.isEmpty) {
        await _db!.update(
          'Habits',
          {'streaks': 0},
          where: 'id = ?',
          whereArgs: [habit['id']],
        );
        continue;
      }

      int streak = 0;

      String currentdates = todaysDateFormatted();
      DateTime current = DateTime.parse(currentdates);

      for (var completion in completions) {
        bool isCompleted = completion['isCompleted'] == 1;
        bool isSkipped = completion['isSkipped'] == 1;

        String completionDat = completion['lastUpdated'].toString();
        DateTime completionDate = DateTime.parse(completionDat);
        // print("Completion Date: $completionDate");

        int daysDifference = current.difference(completionDate).inDays;
        // print("Days Difference: $daysDifference");

        if (daysDifference <= 1 && isCompleted) {
          // Completed today
          streak++;
        } else if (daysDifference > 1 || isSkipped || !isCompleted) {
          break;
        }
        // Update the current date to the completion date
        current = completionDate;
      }

      await _db!.update(
        'Habits',
        {'streaks': streak},
        where: 'id = ?',
        whereArgs: [habit['id']],
      );
      print("inside update daily Streaks function");
      print("streaks is $streak");
    }
  }

//to update all the streaks for weekly habits
  static Future<void> _updateWeeklyStreaks(
      List<Map<String, dynamic>> habits) async {
    for (var habit in habits) {
      print("Processing weekly habit: ${habit['title']}");
      List<Map<String, dynamic>> completions = await _db!.query(
        'habit_completion',
        where: 'habitId = ?',
        whereArgs: [habit['id']],
        orderBy: 'lastUpdated DESC',
      );

      if (completions.isEmpty) {
        await _db!.update(
          'Habits',
          {'streaks': 0},
          where: 'id = ?',
          whereArgs: [habit['id']],
        );
        continue;
      }

      int streak = 0;
      String currentdates = todaysDateFormatted();
      DateTime current = DateTime.parse(currentdates);

      for (var completion in completions) {
        bool isCompleted = completion['isCompleted'] == 1;
        bool isSkipped = completion['isSkipped'] == 1;
        String completionDat = completion['lastUpdated'].toString();
        DateTime completionDate = DateTime.parse(completionDat);
        print("Completion Date: $completionDate");

        int daysDifference = current.difference(completionDate).inDays;
        print("Days Difference: $daysDifference");

        if (daysDifference <= 7 && isCompleted) {
          // Completed today
          streak++;
        } else if (daysDifference > 7 || isSkipped || !isCompleted) {
          break;
        }
        // Update the current date to the completion date
        current = completionDate;
      }

      await _db!.update(
        'Habits',
        {'streaks': streak},
        where: 'id = ?',
        whereArgs: [habit['id']],
      );

      print("Final streak for habit ${habit['name']} is $streak");
    }
  }

//to update streak at the current habit
  static Future<int> updateStreak(int habitId) async {
    // List of completions of the habit
    List<Map<String, dynamic>> completions = await _db!.query(
      'habit_completion',
      where: 'habitId = ?',
      whereArgs: [habitId],
      orderBy: 'lastUpdated DESC',
    );

    if (completions.isEmpty) {
      // If empty, set streak to 0 and update the habit
      await _db!.update(
        'Habits',
        {'streaks': 0},
        where: 'id = ?',
        whereArgs: [habitId],
      );
      // Move to the next habit
    }

    int streak = 0;
    // DateTime? lastDate;

    for (var completion in completions) {
      bool isCompleted = completion['isCompleted'] == 1;
      bool isSkipped = completion['isSkipped'] == 1;

      if (isCompleted) {
        streak++;
      } else {
        // Stop counting streak if there's an incomplete entry
        break;
      }

      if (isSkipped) {
        streak = 0;
        break;
      }
    }
    await _db!.update(
      'Habits',
      {'streaks': streak},
      where: 'id = ?',
      whereArgs: [habitId],
    );
    return streak;
  }

//to reset streaks of the current habit
  static Future<int> resetStreak(int habitId) async {
    print("inside reset dbhelper, habitId: $habitId");
    int streak = 0;
    int result = await _db!.update(
      'Habits',
      {'streaks': streak},
      where: 'id = ?',
      whereArgs: [habitId],
    );

    print("Update result: $result");
    return result;
  }

  //to pass value of the streaks from the current habit
  static Future<int> fetchStreak(int habitId) async {
    final result = await _db!.query(
      'Habits',
      columns: ['streaks'],
      where: 'id = ?',
      whereArgs: [habitId],
    );

    if (result.isNotEmpty) {
      return result.first['streaks'] as int;
    } else {
      return 0; // Or handle the case when no habit is found
    }
  }

  //creating insights for completion percentages
  static Future<List<Map<String, dynamic>>> getCompletionPercentages() async {
    const String query = '''
     SELECT habits.title AS habitName,
             habit_completion.habitId,
             COUNT(*) as total,
             SUM(habit_completion.isCompleted) as completed,
             SUM(habit_completion.isSkipped) as skipped
      FROM habit_completion
      INNER JOIN habits ON habits.id = habit_completion.habitId
      GROUP BY habit_completion.habitId;
    ''';

    final List<Map<String, dynamic>> result = await _db!.rawQuery(query);

    // Calculate percentages
    return result.map((data) {
      int total = data['total'];
      int completed = data['completed'];
      double completionPercentage = (total > 0) ? (completed / total) * 100 : 0;

      return {
        'habitId': data['habitId'],
        'habitName': data['habitName'],
        'completionPercentage': completionPercentage,
        'total': total,
        'completed': completed,
        'skipped': data['skipped']
      };
    }).toList();
  }

  //to fetch list length of the habits for today
//  Future<int> getHabitListLengthForToday() async {
//     // String todayDate = todaysDateFormatted();
//     List<Habit> habitListForToday = [];

//     for (var habit in habitList) {
//       if (habit.repeat == 'Daily') {
//         habitListForToday.add(habit);
//       } else if (habit.repeat == 'Weekly') {
//         DateTime now = DateTime.now();
//         int weekday = now.weekday;

//         if (createDateTimeObject(habit.date!).weekday == weekday) {
//           habitListForToday.add(habit);
//         } else {
//           print("Weekly habit '${habit.title}' does not match today's weekday");
//         }
//       } else {
//         print(
//             "Unknown repetition type for habit '${habit.title}': ${habit.repeat}");
//       }
//     }
//     print("habit length is  ${habitListForToday.length}");
//     return Future.value(habitListForToday.length);
//   }
// //to remove habits from Habits table and habit_completion table
//   static Future<int> deleteHabitAndCompletions(int habitId) async {
//     // Start a transaction to ensure both deletions happen together
//     return await _db!.transaction((txn) async {
//       await txn.delete(
//         'habit_completion',
//         where: 'habitId = ?',
//         whereArgs: [habitId],
//       );

//       return await txn.delete(
//         _tableName,
//         where: 'id = ?',
//         whereArgs: [habitId],
//       );
//     });
//   }
}
