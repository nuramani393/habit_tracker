import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:habit_tracker/src/common_widgets/form/form_header_widget.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login.dart';
import 'package:habit_tracker/src/features/authentication/screens/signup/widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                    image: welcome, title: sTitle, subTitle: sSubTitle),
                SignUpFormWidget(),
                Column(
                  children: [
                    // Text("OR",
                    //     style: Theme.of(context).textTheme.headlineSmall),
                    // const SizedBox(height: formHeight - 10),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: OutlinedButton.icon(
                    //     onPressed: () {},
                    //     icon: Image(image: AssetImage(google), width: 20.0),
                    //     label: Text("Sign-In with Google",
                    //         style: Theme.of(context).textTheme.headlineSmall),
                    //   ),
                    // ),
                    TextButton(
                      onPressed: () => Get.to(() => LoginScreen()),
                      child: Text.rich(
                        TextSpan(
                          text: haveacc,
                          style: Theme.of(context).textTheme.headlineSmall,
                          children: const [
                            TextSpan(
                              text: "Login",
                              style: TextStyle(color: darkColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
