import 'package:flutter/material.dart';
import 'package:habit_tracker/src/common_widgets/form/form_header_widget.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/constants/text_strings.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login_footer_widget.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(defaultSize),
          child: const Column(
            children: [
              // LoginHeaderWidget(size: size),
              FormHeaderWidget(
                  image: welcome,
                  title: lTitle,
                  subTitle: lSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  heightBetween: 30.0,
                  textAlign: TextAlign.start),

              //Form Widgets
              LoginForm(),

              LoginFooterWidget()
            ],
          ),
        ),
      )),
    );
  }
}
