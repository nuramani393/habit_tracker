import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';

class CompletionPercentage extends StatelessWidget {
  final RxList<Map<String, dynamic>> data;

  const CompletionPercentage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final List<double> percentages = data
          .map<double>(
              (item) => (item['completionPercentage'] as double?) ?? 0.0)
          .toList(); // Handle null values here

      final List<String> habitNames = data
          .map<String>((item) => (item['habitName'] as String?) ?? '')
          .toList(); // List of habit names

      return Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: midColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        // Set a fixed height or use constraints
        child: ListView.builder(
          itemCount: percentages.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 100, // Set a fixed width or use constraints
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    habitNames[index]
                        .split(' ')
                        .map((word) => word.capitalize)
                        .join(' '),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: black, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${percentages[index].toStringAsFixed(0)}%',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: black,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  // Add any other chart elements here
                ],
              ),
            );
          },
        ),
      );
    });
  }
}
