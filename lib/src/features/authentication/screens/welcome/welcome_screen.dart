import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login.dart';
import 'package:habit_tracker/src/features/authentication/screens/signup/signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var brightness = mediaQuery.platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDarkMode ? darkColor : whiteColor,
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 100.0),
            Image(image: const AssetImage(welcome), height: height * 0.4),
            Column(
              children: [
                Text(wTitle, style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(height: 10.0),
                Text(
                  wSubTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 165.0),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.to(() => LoginScreen()),
                    child: const Text(
                      "LOGIN",
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => SignUpScreen()),
                    child: const Text("SIGNUP"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
