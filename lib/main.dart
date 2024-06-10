import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:habit_tracker/firebase_options.dart';
import 'package:habit_tracker/src/features/authentication/screens/forget_password/forget_password_mail/forget_password_mail.dart';
import 'package:habit_tracker/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:habit_tracker/src/features/authentication/screens/login/login.dart';
import 'package:habit_tracker/src/features/authentication/screens/signup/signup_screen.dart';
import 'package:habit_tracker/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:habit_tracker/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:habit_tracker/src/features/core/db/db_helper.dart';
import 'package:habit_tracker/src/features/core/screens/dashboard/dashboard.dart';
import 'package:habit_tracker/src/features/core/screens/insights/insights.dart';
import 'package:habit_tracker/src/features/core/screens/settings/settings.dart';
import 'package:habit_tracker/src/repositories_authentication/authentication_repository.dart';
import 'package:habit_tracker/src/utils/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  final dbHelper = DBHelper();
  await dbHelper.initDb();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // home: SignUpScreen(),
      // home: WelcomeScreen(),
      // home: Dashboard(),
      // home: Insights(),

      // home: LoginScreen(),
      // home: ForgetPasswordMailScreen(),
      home: SplashSreen(),
    );
  }
}
