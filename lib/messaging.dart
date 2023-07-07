import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_fcm/flutter_fcm.dart';

class Messaging {
  static String token = 'token';

  static deleteToken() {
    FCM.deleteRefreshToken();
  }

  static Future<void> onNotificationReceived(RemoteMessage message) async {
    await Firebase.initializeApp();

    print('Handling a message ${message.messageId}');
  }

  static initFCM() async {
    try {
      await FCM.initializeFCM(
        onNotificationReceived: onNotificationReceived,
        onNotificationPressed: (Map<String, dynamic> data) {
          print(data);
        },
        onTokenChanged: (token) {
          if (token != null) {
            Messaging.token = token;
            print(token);
            //MessagingService.sendToken(fcmToken: token);
          }
        },
        icon: '@mipmap/ic_launcher',
      );
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(e, null);
    }
  }
}
