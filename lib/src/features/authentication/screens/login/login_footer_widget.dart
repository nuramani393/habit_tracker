import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/screens/signup/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Text("OR", style: Theme.of(context).textTheme.headlineSmall),
        // const SizedBox(height: formHeight - 10),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {},
        //     icon: Image(
        //       image: AssetImage(google),
        //       width: 20.0,
        //     ),
        //     label: Text("Sign-In with Google",
        //         style: Theme.of(context).textTheme.headlineSmall),
        //   ),
        // ),
        const SizedBox(height: formHeight - 20),
        TextButton(
          onPressed: () => Get.to(() => SignUpScreen()),
          child: Text.rich(
            TextSpan(
              text: donthaveacc,
              style: Theme.of(context).textTheme.headlineSmall,
              children: const [
                TextSpan(
                  text: "Signup",
                  style: TextStyle(color: darkColor),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
