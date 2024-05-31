import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/models/habit_model.dart';

class HabitTile extends StatelessWidget {
  final Habit? habit;
  const HabitTile(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: darkColor,
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  habit?.title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: whiteColor),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text("${habit!.time} ",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ],
                ),
                SizedBox(height: 12),
                Text(habit?.desc ?? "",
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              "${habit!.category} ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ]),
      ),
    );
  }

//
}
