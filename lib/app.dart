import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:context_holder/context_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
import 'package:janitor/utils/app_constants.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ConnectivityAppWrapper(
          app: MaterialApp(
            navigatorKey: ContextHolder.key,
            debugShowCheckedModeBanner: false,
            title: AppName.APP_NAME,
            builder: EasyLoading.init(
              builder: (context, child) {
                return child!;
              },
            ),
            theme: ThemeData(
              disabledColor: Colors.grey,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            home: child,
          ),
        );
      },
      child: const LoginScreen(),
    );
  }
}
