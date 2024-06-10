import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';
// import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final password = TextEditingController();
  final email = TextEditingController();

  // void registerUser(String email, String password, String name) {
  //   AuthenticationRepository.instance.createUserWithEmailAndPassword(
  //     email,
  //     password,
  //     name,
  //   );
  // }
  void loginUser(String email, String password) {
    print("inside registerUser method in SignUpController.dart ");
    AuthenticationRepository.instance
        .loginUserWithEmailAndPassword(email, password);
  }
}
