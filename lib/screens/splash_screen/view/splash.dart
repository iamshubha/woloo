import 'package:dio_log/overlay_draggable_button.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/bloc/core_bloc.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/view/supervisor_dashboard_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_images.dart';

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
    coreBloc.add(CheckUserIsLoggedInOrNot());
    setState(() {
      fcmToken = globalStorage.getFCMToken();
      print("fcccccccmmmmmm---$fcmToken");
    });
    init();
    showDebugBtn(context);
  }

  Future getDeviceToken() async {
    //request user permission for push notification
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    print("FCM_token --" + deviceToken.toString());
    globalStorage.saveFCMToken(accessFCMToken: deviceToken.toString());
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

    var iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        sound: 'notification.caf'); //put your own sound text here

    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      '10000012', 'smart_hygiene_channel',
      sound: RawResourceAndroidNotificationSound('notification'),
      // largeIcon: 'sample_large_icon',
      // largeIconBitmapSource: BitmapSource.Drawable,
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

      //im gonna have an alertdialog when clicking from push notification
      // Alert(
      //   context: context,
      //   type: AlertType.error,
      //   title: title,
      //   // title from push notification data
      //   style: AlertStyle(
      //       titleStyle: TextStyle(color: AppColors.redText),
      //       backgroundColor: AppColors.black),
      //   desc: description,
      //   // description from push notification data
      //   buttons: [
      //     DialogButton(
      //       child: Text(
      //         "COOL",
      //         style: TextStyle(color: Colors.white, fontSize: 20),
      //       ),
      //       onPressed: () => Navigator.pop(context),
      //       width: 120,
      //     )
      //   ],
      // ).show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoreBloc, CoreState>(
      bloc: coreBloc,
      listener: (context, state) {
        if (state is CoreSuccess) {
          try {
            setState(() {
              roleId = globalStorage.getRoleId();
              print("screen role id ----- " + roleId.toString());
              if (roleId == "") {
                print("role id is null");
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>const LoginScreen(),
                //   ),
                // );
              }
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
            coreBloc.add(UpdateToken(token: fcmToken!));
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

  // Future<void> _showNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //       AndroidNotificationDetails(
  //     'your_channel_id',
  //     'your_channel_name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     styleInformation: BigTextStyleInformation(''),
  //     color: Colors.blue, // Change this color to your desired background color
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //       NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await _notification.show(
  //     0,
  //     'Notification Title',
  //     'Notification Body',
  //     platformChannelSpecifics,
  //     payload: 'item x',
  //   );
  // }
}
