import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/features/authentication/models/user_model.dart';

import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';
import 'package:habit_tracker/src/repositories_authentication/user_repository.dart';

class AccountController extends GetxController {
  static AccountController get instance => Get.find();

  final name = TextEditingController();
  final password = TextEditingController();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      Get.snackbar("Error", "Login to continue");
    }
  }

  updateRecord(UserModel user) async {
    await _userRepo.updateUserDetails(user);
  }

  deleteRecord(String userID) async {
    await _userRepo.deleteUserAccount(userID);
  }
}
