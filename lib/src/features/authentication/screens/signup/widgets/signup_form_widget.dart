import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/authentication/controllers/signup_controller.dart';
import 'package:habit_tracker/src/features/authentication/models/user_model.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.name,
              decoration: const InputDecoration(
                label: Text("Name"),
                prefixIcon: Icon(
                  Icons.person_outline_rounded,
                ),
              ),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: formHeight - 20),
            TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: formHeight - 20),
            TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  prefixIcon: Icon(
                    Icons.fingerprint,
                  ),
                ),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: formHeight - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   SignUpController.instance.registerUser(
                    //     controller.email.text.trim(),
                    //     controller.password.text.trim(),
                    //   );
                    // }
                    final user = UserModel(
                      email: controller.email.text.trim(),
                      name: controller.name.text.trim(),
                      password: controller.password.text.trim(),
                    );
                    SignUpController.instance.createUser(user);
                  },
                  child: const Text("SIGNUP")),
            )
          ],
        ),
      ),
    );
  }
}
