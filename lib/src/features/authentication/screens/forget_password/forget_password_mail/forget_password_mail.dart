import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habit_tracker/src/common_widgets/form/form_header_widget.dart';
import 'package:habit_tracker/src/constants/image_strings.dart';
import 'package:habit_tracker/src/constants/sizes.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(defaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: defaultSize * 4),
                const FormHeaderWidget(
                  image: forget,
                  title: "Forget Password",
                  subTitle: "Enter your e-mail to reset your password.",
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: formHeight),
                Form(
                    child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text("E-Mail"),
                        prefixIcon: Icon(Icons.mail_outline_rounded),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Next"),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
