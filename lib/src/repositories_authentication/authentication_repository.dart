import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login.dart';
import 'package:habit_tracker/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:habit_tracker/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/repositories/exceptions/login_failure.dart';
import 'package:habit_tracker/src/repositories_authentication/exceptions/login_failure.dart';
import 'package:habit_tracker/src/repositories_authentication/exceptions/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //variables
  // final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;

////Called from main.dart on app launch
  @override
  void onReady() {
    // SplashSreen.remove();
    super.onReady();
    // Future.delayed(Duration(milliseconds: 500));
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    // screenRedirect();
  }

  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : Get.offAll(() => Dashboard());
  }

  // Future<void> createUserWithEmailAndPassword(
  //     String email, String password, String name) async {
  //   try {
  //     // await _auth.createUserWithEmailAndPassword(
  //     //   email: email,
  //     //   password: password,
  //     // );
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // Update the user's display name
  //     await userCredential.user!.updateDisplayName(name);

  //     firebaseUser.value != null
  //         ? Get.offAll(() => Dashboard())
  //         : Get.to(() => WelcomeScreen());

  //     Get.snackbar('Success', 'User created successfully');
  //   } on FirebaseAuthException catch (e) {
  //     final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
  //     print("Firebase Auth Exception: - ${ex.message}");
  //     throw ex;
  //   } catch (_) {
  //     final ex = SignUpWithEmailAndPasswordFailure();
  //     print("Exception: - ${ex.message}");
  //     throw ex;
  //   }
  // }

  //
  // Future<String?> createUserWithEmailAndPassword(
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      print("inside AuthenticationRepository.create user");
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      firebaseUser.value != null
          ? Get.offAll(() => LoginScreen())
          : Get.to(() => WelcomeScreen());

      Get.snackbar('Success', 'User created successfully');
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Firebase Auth Exception:', ' ${ex.message}');

      print("Firebase Auth Exception: - ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = SignUpWithEmailAndPasswordFailure();
      print("Exception: - ${ex.message}");
      throw ex;
    }
  }

  // Future<String?> loginUserWithEmailAndPassword(
  Future<void> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      final ex = LoginWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Firebase Auth Exception:', ' ${ex.message}');

      print("Firebase Auth Exception: - ${ex.message}");
      throw ex;
    } catch (_) {
      final ex = LoginWithEmailAndPasswordFailure();
      print("Exception: - ${ex.message}");
      throw ex;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<bool> verifyOTP(String otp) async {
    // try {
    var credentials = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: 'verificationId', smsCode: otp));
    return credentials.user != null ? true : false;

    // } on FirebaseAuthException catch (e) {
    //   final ex = LoginWithEmailAndPasswordFailure.code(e.code);
    //   Get.snackbar('Firebase Auth Exception:', ' ${ex.message}');

    //   print("Firebase Auth Exception: - ${ex.message}");
    //   throw ex;
    // } catch (_) {
    //   final ex = LoginWithEmailAndPasswordFailure();
    //   print("Exception: - ${ex.message}");
    //   throw ex;
    // }
  }
  // void screenRedirect() async {
  //   //   await Future.delayed(
  //   //       Duration(milliseconds: 500)); // Add delay for animation
  //   //   final bool isFirstTime = deviceStorage.read('isFirstTime') ?? true;
  //   //   isFirstTime
  //   //       ? Get.offAll(() => SplashSreen())
  //   //       : Get.offAll(() => LoginScreen());
  // }
}
