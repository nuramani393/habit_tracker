import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/authentication/controllers/login_controller.dart';
import 'package:habit_tracker/src/features/authentication/screens/forget_password/forget-password_options/forget_password_model_bottom_sheet.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Form Field Login
            //Email
            TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: "E-mail",
                  border: OutlineInputBorder(),
                ),
                style: Theme.of(context).textTheme.headlineSmall),

            const SizedBox(height: formHeight - 20),

            //Password
            TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: "Password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: null,
                    icon: Icon(Icons.remove_red_eye_sharp),
                  ),
                ),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: formHeight - 5),

            //Button Forget Pasword
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    ForgetPasswordScreen.buildShowModalBottomSheet(context);
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: darkColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  )),
            ),
            const SizedBox(height: formHeight - 20),
            //Button Login
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // onPressed: () => Get.to(() => Dashboard()),
                onPressed: () {
                  // if (_formKey.currentState!.validate()) {
                  //   SignUpController.instance.registerUser(
                  //       controller.email.text.trim(),
                  //       controller.password.text.trim(),
                  //       controller.name.text);
                  // }
                  if (_formKey.currentState!.validate()) {
                    LoginController.instance.loginUser(
                      controller.email.text.trim(),
                      controller.password.text.trim(),
                    );
                  }
                },
                child: const Text(
                  "LOGIN",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
