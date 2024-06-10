import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/core/screens/settings/widgets/listview.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({super.key});

  @override
  State<AppearancePage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AppearancePage> {
  late bool isDark;
  // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          SizedBox(height: 20),
          headerAppearance(context),
          Expanded(
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: ListTileWidget(
                    title: "System",
                    leadingIcon: Icons.contrast,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTileWidget(
                    title: "Light Theme",
                    leadingIcon: Icons.light_mode_rounded,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: ListTileWidget(
                    title: "Dark Theme",
                    leadingIcon: Icons.bedtime_rounded,
                  ),
                ),
              ],
            ),
          )
          // SizedBox(height: 30),
        ],
      ),
    );
  }

  Padding headerAppearance(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 30, 25, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.navigate_before_rounded,
              size: 35,
              color: darkColor,
            ),
          ),
          Expanded(
            child: Text("Appearance",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
          SizedBox(width: 40),
        ],
      ),
    );
  }
}
