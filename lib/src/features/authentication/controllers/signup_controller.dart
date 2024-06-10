import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/features/authentication/models/user_model.dart';
import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';
import 'package:habit_tracker/src/repositories_authentication/user_repository.dart';
// import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final name = TextEditingController();

  final userRepo = Get.put(UserRepository());

  // void registerUser(String email, String password, String name) {
  //   AuthenticationRepository.instance.createUserWithEmailAndPassword(
  //     email,
  //     password,
  //     name,
  //   );
  // }
  // void registerUser(String email, String password) {
  //   print("inside registerUser method in SignUpController.dart ");
  //   AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password);
  // }
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(user.email, user.password);
  }

  //   void registerUser(String email, String password) {
  //   String? error = AuthenticationRepository.instance
  //       .createUserWithEmailAndPassword(email, password) as String?;
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(
  //       message: error.toString(),
  //     ));
  //   }
  // }
}
