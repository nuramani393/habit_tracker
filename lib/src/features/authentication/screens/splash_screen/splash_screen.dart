import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/controllers/splash_screen_controller.dart';
// import 'package:yes_to_habit/src/constants/colors.dart';

class SplashSreen extends StatelessWidget {
  SplashSreen({Key? key}) : super(key: key);

  final splashController = Get.put(SplashScreenController());
  @override
  Widget build(BuildContext context) {
    splashController.startAnimation();
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: splashController.animate.value ? 0 : -20,
                left: splashController.animate.value ? 0 : -30,
                child: const Image(
                  image: AssetImage(splashTopIcon),
                  height: 180,
                  width: 200,
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: 120,
                left: splashController.animate.value ? defaultSize : -80,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        bismillah,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        appName,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                bottom: splashController.animate.value ? 200 : 0,
                left: (MediaQuery.of(context).size.width - 350) / 2,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: const Image(
                    image: AssetImage(splashImage),
                    height: 350,
                    width: 350,
                  ),
                ),
              ),
            ),
            //bottom
            Obx(
              () => AnimatedPositioned(
                duration: const Duration(milliseconds: 2400),
                bottom: splashController.animate.value ? 20 : 0,
                right: defaultSize,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 2000),
                  opacity: splashController.animate.value ? 1 : 0,
                  child: const Image(
                    image: AssetImage(splashBottomIcon),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
