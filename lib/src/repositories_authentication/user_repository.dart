import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/constants/colors.dart';
import 'package:habit_tracker/src/features/authentication/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createUser(UserModel user) async {
    // await _db
    //     .collection('Users')
    //     .add(user.toJson())
    //     .whenComplete(
    //       () => Get.snackbar(
    //           "Success", "Your account has been created.Please Log in",
    //           snackPosition: SnackPosition.BOTTOM,
    //           backgroundColor: darkColor,
    //           colorText: whiteColor),
    //     )
    await _db
        .collection('Users')
        .add(user.toJson())
        .whenComplete(
          () => (),
        )
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: lightgrey,
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection('Users').where('email', isEqualTo: email).get();
    final userdata = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userdata;
  }

  Future<void> updateUserDetails(UserModel user) async {
    // await _db.collection('Users').doc(user.id).update(user.toJson());
    try {
      await _db.collection('Users').doc(user.id).update(user.toJson());
      Get.snackbar('Success', 'User updated successfully');
    } catch (e) {
      print('Error updating user details: $e');
    }
  }

  Future<void> deleteUserAccount(String userId) async {
    try {
      await _db.collection('Users').doc(userId).delete();
      Get.snackbar('Success', 'Account deleted successfully');
    } catch (e) {
      print('Error deleting user account: $e');
    }
  }
}
