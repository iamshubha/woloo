import 'dart:io';

import 'package:Woloo_Smart_hygiene/core/bloc/core_bloc.dart';
import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/view/supervisor_dashboard_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';

import '../../dashboard/view/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CoreBloc coreBloc = CoreBloc();
  GlobalStorage globalStorage = GetIt.instance();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      coreBloc.add(CheckUserIsLoggedInOrNot());
    }

    if (Platform.isIOS) {
      requestTracking();
    }

    createNotificationChannel();
    initFCM();
    updateDeviceToken();
    showDebugBtn(context);
  }

  Future updateDeviceToken() async {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? deviceToken = await messaging.getToken();
    if (deviceToken != null) coreBloc.add(UpdateToken(token: deviceToken));
  }

  DarwinNotificationDetails iOSFCMConfig() {
    return const DarwinNotificationDetails(sound: 'notification.caf');
  }

  AndroidNotificationDetails androidFCMConfig() {
    return const AndroidNotificationDetails(
      '10000012',
      'smart_hygiene_channel',
      sound: RawResourceAndroidNotificationSound('notification'),
      enableLights: true,
      color: AppColors.buttonColor,
      ledColor: Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.max,
      playSound: true,
      priority: Priority.high,
    );
  }

  initFCM() async {
    var notification = FlutterLocalNotificationsPlugin();

    notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidFCMConfig(),
      iOS: iOSFCMConfig(),
    );

    FirebaseMessaging.onMessage.listen((message) async {
      await notification.show(
        10000012,
        message.notification!.title,
        message.notification!.body,
        platformChannelSpecifics,
      );
    });

    // listen for user to click on notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage) {
      String? title = remoteMessage.notification!.title;
      String? description = remoteMessage.notification!.body;
    });
  }

  void createNotificationChannel() async {
    var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var androidNotificationChannel = const AndroidNotificationChannel(
      "10000012",
      "smart_hygiene_channel",
      sound: RawResourceAndroidNotificationSound('notification'),
      enableLights: true,
      ledColor: Color.fromARGB(255, 255, 0, 0),
      importance: Importance.max,
      playSound: true,
    );
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(androidNotificationChannel);
  }

  Future<void> requestTracking() async {
    try {
      final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await showCustomTrackingDialog(context);
        await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status = await AppTrackingTransparency.requestTrackingAuthorization();
      }
      final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
      print("UUID: $uuid");
      coreBloc.add(CheckUserIsLoggedInOrNot());
    } catch (e) {
      print(e);
    }
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async => await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(MySplashScreenConstants.DEAR_USER.tr()),
          content: Text("${MySplashScreenConstants.PRIVACY.tr()}"
              "${MySplashScreenConstants.PERMISSION.tr()}"
              "${MySplashScreenConstants.ADS.tr()}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(MySplashScreenConstants.CONTINUE.tr()),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoreBloc, CoreState>(
      bloc: coreBloc,
      listener: (context, state) {
        if (state is CoreSuccess) {
          try {
            if (!state.isLoggedIn) throw "Not logged in";

            int roleId = globalStorage.getRoleId();

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => roleId == 1 ? const Dashboard() : const SupervisorDashboard(),
              ),
              (route) => false,
            );
          } catch (e) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                color: AppColors.buttonColor,
                backgroundColor: AppColors.white.withOpacity(0.1),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.splash_logo,
                      scale: 5,
                    ),
                  ],
                ),
              ),
              Text(MySplashScreenConstants.LOADING.tr()),
            ],
          ),
        ),
      ),
    );
  }
}
