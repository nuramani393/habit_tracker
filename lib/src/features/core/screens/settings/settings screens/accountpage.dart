import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/constants/sizes.dart';
import 'package:habit_tracker/src/features/authentication/models/user_model.dart';
import 'package:habit_tracker/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:habit_tracker/src/features/core/controllers/account_controller.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            headerAccount(context),
            FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel userData = snapshot.data as UserModel;
                      controller.name.text = userData.name;
                      controller.password.text = userData.password;
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(25.0, 25, 25, 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: formHeight - 10.0),
                          child: Form(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: whiteColor,
                                  child: TextFormField(
                                    controller: controller.name,
                                    // initialValue: userData.name,
                                    decoration: const InputDecoration(
                                      fillColor: whiteColor,
                                      label: Text("Name",
                                          style: TextStyle(color: black)),
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                        color: black,
                                      ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  color: whiteColor,
                                  child: TextFormField(
                                      readOnly: true,
                                      initialValue: userData.email,
                                      decoration: const InputDecoration(
                                        label: Text("E-mail",
                                            style: TextStyle(color: black)),
                                        prefixIcon: Icon(
                                          Icons.email_outlined,
                                          color: black,
                                        ),
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  color: whiteColor,
                                  child: TextFormField(
                                    controller: controller.password,
                                    // initialValue: userData.name,
                                    decoration: const InputDecoration(
                                      fillColor: whiteColor,
                                      label: Text("Password",
                                          style: TextStyle(color: black)),
                                      prefixIcon: Icon(
                                        Icons.person_outline_rounded,
                                        color: black,
                                      ),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () async {
                                    final updateData = UserModel(
                                      id: userData.id,
                                      name: controller.name.text.trim(),
                                      email: userData.email,
                                      password: controller.password.text.trim(),
                                    );
                                    await controller.updateRecord(updateData);
                                  },
                                  child: Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: darkColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      width: 150,
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                          "Save",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.w100),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: formHeight - 20),
                                TextButton(
                                  child: Text("Delete Account",
                                      style: TextStyle(color: Colors.red)),
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(
                                        userData.id!); // Close the dialog
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                          child: Text(
                        snapshot.error.toString(),
                      ));
                    } else {
                      return const Center(child: Text("Something Went Wrong"));
                    }
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(String userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: whiteColor,
          title: Text(
            "Confirm Deletion",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          content: Text(
            "Are you sure you want to delete this account?",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.w200),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: darkColor)),
              onPressed: () {
                Get.back(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("Delete", style: TextStyle(color: darkColor)),
              onPressed: () async {
                await controller.deleteRecord(userId);
                Get.offAll(WelcomeScreen());
              },
            ),
          ],
        );
      },
    );
  }

  Padding headerAccount(BuildContext context) {
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
            child: Text("Account",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge),
          ),
        ],
      ),
    );
  }
}
