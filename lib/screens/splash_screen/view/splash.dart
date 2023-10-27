import 'dart:io';

import 'package:Woloo_Smart_hygiene/core/bloc/core_bloc.dart';
import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/view/supervisor_dashboard_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import '../../dashboard/view/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CoreBloc coreBloc = CoreBloc();
  GlobalStorage globalStorage = GetIt.instance();
  late int? roleId;
  String? fcmToken;
  var _notification;

  @override
  void initState() {
    super.initState();
    setState(() {
      fcmToken = globalStorage.getFCMToken();
    });
    if (Platform.isAndroid) {
      coreBloc.add(CheckUserIsLoggedInOrNot());
    }

    if (Platform.isIOS) {
      requestTracking();
    }

    init();
    showDebugBtn(context);
  }

  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    globalStorage.saveFCMToken(accessFCMToken: deviceToken ?? '');
    fcmToken = deviceToken;
    print("Device Token----->${deviceToken}");
    return (deviceToken == null) ? "" : deviceToken;
  }

  init() async {
    _notification = FlutterLocalNotificationsPlugin();
    _notification.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
    );

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      sound: 'notification.caf',
    ); //put your own sound text here

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
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

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFICATION ######");
    print("TOKENNNNNNNN.....-----" + deviceToken);
    print("############################################################");
    setState(() {
      fcmToken = globalStorage.getFCMToken();
      print("FCM Token----->${fcmToken}");
    });

    FirebaseMessaging.onMessage.listen((message) async {
      await _notification.show(
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

  Future<void> requestTracking() async {
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        await showCustomTrackingDialog(context);
        await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
      }
      final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
      print("UUID: $uuid");
      coreBloc.add(CheckUserIsLoggedInOrNot());
    } catch (e) {
      print(e);
    }
  }

  Future<void> showCustomTrackingDialog(BuildContext context) async =>
      await showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Dear User'),
          content: const Text(
            'We care about your privacy and data security. We keep this app free by showing ads. '
            'Can we continue to use your data to tailor ads for you?\n\nYou can change your choice anytime in the app settings. '
            'Our partners will collect data and use a unique identifier on your device to show you ads.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue'),
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
            setState(() {
              roleId = globalStorage.getRoleId();
            });
          } catch (e) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
              (route) => false,
            );
          }

          if (state.isLoggedIn) {
            coreBloc.add(UpdateToken(token: fcmToken ?? ''));

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    roleId == 1 ? Dashboard() : SupervisorDashboard(),
              ),
              (route) => false,
            );
          } else {
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
              const Text("Loading..."),
            ],
          ),
        ),
      ),
    );
  }
}
