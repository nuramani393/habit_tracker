import 'package:flutter/material.dart';
import 'package:habit_tracker/src/constants/sizes.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10.0),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
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
                decoration: const InputDecoration(
                  label: Text("E-mail"),
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: formHeight - 20),
            TextFormField(
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
              child:
                  ElevatedButton(onPressed: () {}, child: const Text("SIGNUP")),
            )
          ],
        ),
      ),
    );
  }
}
