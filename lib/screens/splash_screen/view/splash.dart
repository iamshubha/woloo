import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:janitor/core/bloc/core_bloc.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
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

  @override
  void initState() {
    super.initState();
    coreBloc.add(CheckUserIsLoggedInOrNot());
    showDebugBtn(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CoreBloc, CoreState>(
      bloc: coreBloc,
      listener: (context, state) {
        if (state is CoreSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => state.isLoggedIn ? const Dashboard(isFromJanitor: true, isFromSupervisor: false) : const LoginScreen(),
            ),
          );
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
