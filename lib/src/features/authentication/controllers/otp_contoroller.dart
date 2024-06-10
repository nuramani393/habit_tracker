import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController instance = Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(() => Dashboard()) : Get.back();
  }
}
