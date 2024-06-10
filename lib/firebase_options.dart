// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCKQ08euxlj19qdwlQSg_8xPI-GL50l3vk',
    appId: '1:201108182391:android:1691f9f3c63afe6429fd72',
    messagingSenderId: '201108182391',
    projectId: 'habit-tracker-fe627',
    storageBucket: 'habit-tracker-fe627.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSFpt_2Gg0B5WxwLGGvu8MiYQeRXDrvCo',
    appId: '1:201108182391:ios:5ce02ba1586b2ad629fd72',
    messagingSenderId: '201108182391',
    projectId: 'habit-tracker-fe627',
    storageBucket: 'habit-tracker-fe627.appspot.com',
    androidClientId:
        '201108182391-chphiscrmqj8ubl0r39bqgp16nql2sms.apps.googleusercontent.com',
    iosClientId:
        '201108182391-rpq3c4nnvr734gcopt13e9ph5sp85ifi.apps.googleusercontent.com',
    iosBundleId: 'com.example.habitTracker',
  );
}
