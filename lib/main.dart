import 'package:Woloo_Smart_hygiene/firebase_options.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:Woloo_Smart_hygiene/injection_container.dart' as di;
import 'app.dart';
// import 'messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  await di.init();

  // Messaging.initFCM();

  if (kReleaseMode) {
    /// Pass all uncaught "fatal" errors from the framework to Crashlytics
    // FlutterError.onError = (errorDetails) {
    //   FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    // };
    //
    // /// Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    // PlatformDispatcher.instance.onError = (error, stack) {
    //   FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    //   return true;
    // };
  }

  /// change status bar color
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );

  // runApp(
  //   EasyLocalization(
  //     supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
  //     path: 'assets/translations',
  //     fallbackLocale: const Locale('en', 'US'),
  //     child: const Main(),
  //   ),
  // );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(
                EasyLocalization(
                  supportedLocales: const [
                    Locale('en', 'US'),
                    Locale('hi', 'IN'),
                  ],
                  path: 'assets/translations',
                  fallbackLocale: const Locale('en', 'US'),
                  child: const App(),
                ),
              )

          // runApp(const App()),
          );
}
