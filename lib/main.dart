import 'package:apicallingdemo/pages/Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF87cca5), // transparent status bar
  ));
  await Firebase.initializeApp();
  // Workmanager().initialize(
  //     callbackDispatcher,
  //     isInDebugMode: false
  // );
  // Workmanager().registerPeriodicTask(
  //   "2",
  //   "simplePeriodicTask",
  //   frequency: const Duration(seconds: 10),
  // );
  runApp(const MyApp());
}

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//
//     // initialise the plugin of flutterlocalnotifications.
//     FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
//
//     // app_icon needs to be a added as a drawable
//     // resource to the Android head project.
//     var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = const IOSInitializationSettings();
//
//     // initialise settings for both Android and iOS device.
//     var settings = InitializationSettings(android: android, iOS: iOS);
//     flip.initialize(settings);
//     _showNotificationWithDefaultSound(flip);
//     return Future.value(true);
//   });
// }

// Future _showNotificationWithDefaultSound(flip) async {
//
//   // Show a notification after every 15 minute with the first
//   // appearance happening a minute after invoking the method
//   var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       importance: Importance.max,
//       priority: Priority.high
//   );
//   var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
//
//   // initialise channel platform for both Android and iOS device.
//   var platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: iOSPlatformChannelSpecifics
//   );
//   await flip.show(0, 'GeeksforGeeks',
//       'Your are one step away to connect with GeeksforGeeks',
//       platformChannelSpecifics, payload: 'Default_Sound'
//   );
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  late FirebaseMessaging messaging;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      if (kDebugMode) {
        print(value);
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      if (kDebugMode) {
        print("message recieved");
        print(event.notification!.body);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (kDebugMode) {
        print('Message clicked!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Movie DB',
      home: Home(),
    );
  }
}



