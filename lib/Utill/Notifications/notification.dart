import 'dart:developer';
import 'dart:io';

import 'package:core_project/Utill/Comman.dart';
import 'package:core_project/Utill/Local_User_Data.dart';
import 'package:core_project/View/Screen/DashBoard/DashBoardSCreen.dart';
import 'package:core_project/View/Screen/generalScreen/my_account.dart';
import 'package:core_project/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:nb_utils/nb_utils.dart' as ub;

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("********************(*(*(*(*(*(<<<<<>>>>");
  log('Handling a background message ${message.data}');
  navigateToEditAccount(navigatorKey.currentContext!);
}

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'your channel id', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.',
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
AppLifecycleState appLifecycleState = AppLifecycleState.detached;
String token = "";
String apns = "";
getToken() async {
  try {
    token = (await FirebaseMessaging.instance.getToken())!;
    if(Platform.isIOS)
      {
        apns = (await FirebaseMessaging.instance.getAPNSToken())!;
      }

    talker.info("[ App token: $token ]");
    talker.info("[ apns token: $apns ]");
    return token;
  }catch(e){
    return "";
  }
}

Future<void> onSelectNotification(String? payload) async {
  if (payload != null) {
    debugPrint('notification payload: $payload');
  }
}

/// For main.dart
mainFunctionForNotification() async {
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  await flutterLocalNotificationsPlugin?.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!.createNotificationChannel(channel);
  if (appLifecycleState == AppLifecycleState.inactive ||
      appLifecycleState == AppLifecycleState.paused ||
      appLifecycleState == AppLifecycleState.detached) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true,);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true,);
}
void navigateToEditAccount(BuildContext context) async{
  await globalAccountData.init();
  if(globalAccountData.getLoginInState()==true){
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(builder: (context) => MyAccount()));
  }
}void navigateToDashBoardScreen(BuildContext context) {
  Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(builder: (context) => DashBoardScreen()));
}

/// For Splash screen
void appNotificationDialogFunctions(BuildContext context) async {
  getToken();
  var initializationSettingsAndroid =
  const AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);
  final initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS,);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null) {
      // Show a notification
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'your channel id',
            'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );
      if(ub.platformName() == "android"){
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                    ],
                  ),
                ),
              );
            },
          ).then((_) {
            // After dialog is dismissed, navigate to another screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashBoardScreen()),
            );
          });
        });
      }
    }

    if (notification?.body == "تم رفض الدعوة") {
      print("here");
      navigateToEditAccount(context);
    }else if(notification!.body!.contains("تم قبول طلب الانضمام")){
      navigateToDashBoardScreen(context);
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if(ub.platformName()=="iOS"&&notification?.body == "تم رفض الدعوة"){
      globalAccountData.init();
      globalAccountData.setState("REJECT");
      print("here");
      navigateToEditAccount(context);
    }
    if (notification != null && android != null) {
      if (notification.body == "تم رفض الدعوة") {
        globalAccountData.init();
        globalAccountData.setState("REJECT");
        print("here");
        navigateToEditAccount(context);
      }
      showDialog(
          context: context,
          builder: (_) {
            return MaterialApp(
              home: AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(notification.body!),
                      Row(
                        children: [
                          Text(notification.title!),
                          Text(notification.body!),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          });

    }
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage ? message) {
  //   print("FirebaseMessaging.getInitialMessage");
  //   if(ub.platformName()=="iOS"){
  //     print("here");
  //     navigateToEditAccount(context);
  //   }else{
  //     print("here");
  //     navigateToEditAccount(context);
  //   }
  // });
}

