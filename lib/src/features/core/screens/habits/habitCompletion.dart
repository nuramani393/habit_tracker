import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/core/controllers/habit_controller.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';
import 'package:habit_tracker/src/utils/date/date_time.dart';
import 'package:habit_tracker/src/features/core/screens/habits/AddHabitPage.dart';

class HabitCompletion extends StatefulWidget {
  final Habit? habit;
  final DateTime? selectedDate;

  const HabitCompletion(
      {required this.habit, required this.selectedDate, Key? key})
      : super(key: key);

  @override
  State<HabitCompletion> createState() => _HabitCompletionState();
}

class _HabitCompletionState extends State<HabitCompletion> {
  final _habitController = Get.put(HabitController());

  double width = 0.0;
  double height = 0.0;
  late DateTime? selectedDate; // Declare but don't initialize here
  late bool _isCompleted;
  late bool _isSkipped;
  late int _streak;

// @override
  void initState() {
    super.initState();
    // Initialize the status based on the habit's current state
    _isCompleted = widget.habit?.isCompleted == 1;
    _isSkipped = widget.habit?.isSkipped == 1;
    _streak = widget.habit?.streaks ?? 0;

    selectedDate = widget.selectedDate;
    _habitController.getHabits();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(height: 60),
          appBarDetails(context),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: darkColor,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20, left: defaultSize, right: defaultSize),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Center(
                          child: Text(
                            widget.habit?.title!
                                    .split(' ')
                                    .map((word) => word.capitalize)
                                    .join(' ') ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(
                                    color: whiteColor,
                                    fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                      showAchievement(context),
                      SizedBox(height: 30),
                      bodyStreaks(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column bodyStreaks(BuildContext context) {
    return Column(
      children: [
        if (selectedDate?.year == DateTime.now().year &&
            selectedDate?.month == DateTime.now().month &&
            selectedDate?.day == DateTime.now().day)
          // Display complete and skip buttons if it's today
          ...[
          if (_isCompleted)
            congratsmessage()
          else if (!_isSkipped) ...[
            completebutton(context),
            const SizedBox(height: 15),
          ],
          if (_isSkipped) ...[
            skipedmessage(),
          ] else if (!_isCompleted) ...[
            skippedbutton(context),
          ],
        ],
      ],
    );
  }

  Container appBarDetails(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: darkColor,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(defaultSize, 0, defaultSize, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Text(
                "Back",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: whiteColor, fontWeight: FontWeight.w100),
              ),
            ),
            GestureDetector(
              onTap: () async {},
              child: Text("Edit",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: whiteColor, fontWeight: FontWeight.w100)),
            ),
          ],
        ),
      ),
    );
  }

  completebutton(BuildContext context) {
    return _bottomButton(
        label: "Completed",
        color: bgColor,
        context: context,
        txtcolor: darkColor,
        onTap: () async {
          setState(() {
            _isCompleted = true;
            _isSkipped = false;
            if (widget.habit?.lastUpdated != todaysDateFormatted()) {
              _habitController.moreHabitCompletion(widget.habit!.id!,
                  todaysDateFormatted(), _isCompleted, _isSkipped);
            } else {
              _habitController.updateHabitCompletion(widget.habit!.id!,
                  todaysDateFormatted(), _isCompleted, _isSkipped);
            }
          });
          int newStreak = await _habitController.fetchStreak(widget.habit!.id!);
          _showCompletionDialog(context, newStreak);

          /////
        });
  }

  skippedbutton(BuildContext context) {
    return _bottomButton(
        label: "Skipped",
        color: greyColor,
        context: context,
        txtcolor: whiteColor,
        onTap: () {
          _showSkipConfirmationDialog(context);
          ////
        });
  }

  Text skipedmessage() {
    return const Text(
      "You have skipped this habit today.",
      style: TextStyle(
        fontSize: 16,
        color: whiteColor,
      ),
    );
  }

  Column congratsmessage() {
    return const Column(
      children: [
        Text(
          "Congratulations!",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        Text(
          "You have achieved this habit today.",
          style: TextStyle(
            fontSize: 16,
            color: whiteColor,
          ),
        ),
      ],
    );
  }

  Padding showAchievement(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 450,
        height: 250,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            //   //Here I will use stack to represent achievement of streak
            Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.emoji_events_sharp, // Trophy icon
                  size: 200.0,
                  color: midColor,
                ),
                Positioned(
                  bottom: 100.0,
                  child: Text(_streak.toString(),
                      style: Theme.of(context).textTheme.displayLarge),
                ),
              ],
            ),

            Center(
              child: Text("Current Streak",
                  style: Theme.of(context).textTheme.labelMedium),
            ),
          ],
        ),
      ),
    );
  }

  void _showSkipConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text('Are you sure?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You may lose your streaks.',
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 20),
              const Icon(
                Icons.sentiment_dissatisfied,
                size: 50,
                color: Colors.red,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
                child: const Text('Sure'),
                onPressed: () async {
                  Get.back();
                  setState(() {
                    _isSkipped = true;
                    _isCompleted = false;
                  });

                  if (widget.habit?.lastUpdated != todaysDateFormatted()) {
                    await _habitController.moreHabitCompletion(
                      widget.habit!.id!,
                      todaysDateFormatted(),
                      _isCompleted,
                      _isSkipped,
                    );
                    _habitController.resetStreak(widget.habit!.id!);
                  } else {
                    _habitController.updateHabitCompletion(
                      widget.habit!.id!,
                      todaysDateFormatted(),
                      _isCompleted,
                      _isSkipped,
                    );
                    _habitController.resetStreak(widget.habit!.id!);
                  }

                  // Get the new streak and update the state
                  int newStreak =
                      await _habitController.getStreak(widget.habit!.id!);
                  setState(() {
                    _streak = newStreak;
                  });
                }
                /////
                ),
          ],
        );
      },
    );
  }

  void _showCompletionDialog(BuildContext context, int streaks) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('You have achieved this habit today.',
                  style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 20),
              const Icon(
                Icons.emoji_events_sharp,
                size: 50,
                color: Colors.yellow,
              ),
              const SizedBox(height: 20),
              Text(
                streaks == 1
                    ? 'You got ${streaks + 1} day streak'
                    : 'You got ${streaks + 1} days streaks',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                _habitController
                    .fetchStreak(widget.habit!.id!)
                    .then((newStreak) {
                  setState(() {
                    _streak = newStreak;
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }
  ////
}

_bottomButton({
  required String label,
  required Color color,
  required Color txtcolor,
  required Function()? onTap,
  bool isClose = false,
  required BuildContext context,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 45,
      width: 250,
      decoration: BoxDecoration(
        color: color, // Background color of the box
        borderRadius: BorderRadius.circular(8.0),
        // Border radius of the box
      ),
      child: Center(
        child: Text(label,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: txtcolor)),
      ),
    ),
  );
}
