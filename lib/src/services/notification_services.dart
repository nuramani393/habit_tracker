// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:habit_tracker/src/constants/colors.dart';

// class NotifyHelper {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin(); //

//   initializeNotification() async {
//     //tz.initializeTimeZones();

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: AndroidInitializationSettings('iconfyp'));

//     // Initialize the plugin
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//   }

//   // Method to handle notification selection
//   Future selectNotification(String? payload) async {
//     // Handle notification selection here
//     print("Notification selected with payload: $payload");
//   }

//   // Future selectNotification(String payload) async {
//   //   if (payload != null) {
//   //     print('notification payload: $payload');
//   //   } else {
//   //     print("Notification Done");
//   //   }
//   //   Get.to(() => Container(color: bgColor));
//   // }
// }
