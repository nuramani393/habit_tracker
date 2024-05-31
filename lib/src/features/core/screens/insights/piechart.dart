import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/colors.dart';

class MyPieChart extends StatelessWidget {
  final double completedPercentage;
  final double skippedPercentage;
  final double notDonePercentage;
  final double productivity;

  const MyPieChart({
    Key? key,
    required this.completedPercentage,
    required this.skippedPercentage,
    required this.notDonePercentage,
    required this.productivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200, // Set the desired width
              height: 200,
              child: PieChart(
                swapAnimationDuration: Duration(milliseconds: 200),
                swapAnimationCurve: Curves.easeInOutQuint,
                PieChartData(
                  sections: [
                    PieChartSectionData(
                        color: darkColor,
                        value: completedPercentage,
                        showTitle: false),
                    PieChartSectionData(
                        color: greyColor,
                        value: skippedPercentage,
                        showTitle: false),
                    PieChartSectionData(
                        color: bgColor,
                        value: notDonePercentage,
                        showTitle: false),
                  ],
                ),
              ),
            ),
            Text(
              "${productivity.toStringAsFixed(0)}%",
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ],
        ),
        SizedBox(height: 30),
        _buildLegend(context),
      ],
    );
  }

  Widget _buildLegend(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildLegendItem(context, darkColor, 'Completed'),
          SizedBox(height: 3), // Add some spacing between the items
          _buildLegendItem(context, greyColor, 'Skipped'),
          SizedBox(height: 3),
          _buildLegendItem(context, bgColor, 'To Do'),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, Color color, String text) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w800)),
      ],
    );
  }
}
