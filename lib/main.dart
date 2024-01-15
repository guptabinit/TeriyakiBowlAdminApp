import 'dart:async';
import 'dart:developer' as devtools show log;
import 'dart:io';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart'
    show AndroidServiceInstance;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teriyaki_bowl_admin_app/controllers/receipt_print_controller.dart';
import 'package:teriyaki_bowl_admin_app/resources/firestore_methods.dart';
import 'package:teriyaki_bowl_admin_app/views/onboarding/splash_screen.dart';

import 'utils/colors.dart';

SharedPreferences? preferences;

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  preferences = await SharedPreferences.getInstance();

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  await initializeService(
    flutterLocalNotificationsPlugin,
  );

  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: primaryColor,
    ),
  );

  await Firebase.initializeApp();

  final messaging = FirebaseMessaging.instance;

  await messaging.setAutoInitEnabled(true);

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onBackgroundMessage(
    _firebaseMessagingBackgroundHandler,
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    _firebaseMessagingBackgroundHandler,
  );

  FirebaseMessaging.onMessage.listen(
    _firebaseMessagingBackgroundHandler,
  );

  FirebaseMessaging.onMessage.listen((event) async {
    if (event.notification?.title != null && event.notification?.body != null) {
      _showNotification(flutterLocalNotificationsPlugin, event);

      Map<String, dynamic> data = event.data;
      if (data.containsKey('oid')) {
        String oid = data['oid'];

        Map<String, dynamic>? orderData =
            await FirestoreMethods().getOrderById(oid);

        if (orderData != null) {
          ReceiptPrintController.onPrintReceipt(data: orderData);
        }
      }
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TK Bowl Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

Future<void> initializeService(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
) async {
  final service = FlutterBackgroundService();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    notificationChannelId,
    'recent orders Service',
    description: 'Service for recent orders',
    importance: Importance.high,
  );

  if (Platform.isIOS || Platform.isAndroid) {
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        iOS: DarwinInitializationSettings(),
        android: AndroidInitializationSettings(
          'ic_bg_service_small',
        ),
      ),
    );
  }

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
      autoStartOnBoot: true,
      notificationChannelId: notificationChannelId,
      initialNotificationTitle: 'Teriyaki Bowl Admin',
      initialNotificationContent: 'Ordering service for Teriyaki Bowl',
      foregroundServiceNotificationId: notificationId,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}

Future<void> _showNotification(
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  RemoteMessage event,
) async {
  if (event.notification?.title != null && event.notification?.body != null) {
    await flutterLocalNotificationsPlugin.show(
      DateTime.timestamp().millisecond,
      '${event.notification?.title}',
      '${event.notification?.body}',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          notificationChannelId,
          'recent orders Service',
          channelDescription: 'Service for recent orders',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });

    service.on('stopService').listen((event) {
      service.stopSelf();
    });
  }

  Timer.periodic(
    const Duration(minutes: 1),
    (timer) async {
      'Service is running...'.log();
    },
  );
}

const notificationChannelId = 'notification_foreground_service';
const notificationId = 1000;

extension Logger on Object {
  void log() {
    devtools.log(toString());
  }
}
