import 'dart:async';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_event.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_state.dart';
import 'package:janitor/screens/dashboard/view/local_widgets/dashboard_list.dart';
import 'package:janitor/screens/login/view/login_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/model/Supervisor_model_dashboard.dart';
import 'package:janitor/screens/supervisor_dashboard/view/local_widgets/supervisor_dashboard_list.dart';
import 'package:janitor/screens/task_details_screen/view/task_details.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TemplateScreen extends StatefulWidget {
  final String supervisorName;

  const TemplateScreen({
    Key? key,
    required this.supervisorName,
  }) : super(key: key);

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  int selectedCard = -1;
  GlobalStorage globalStorage = GetIt.instance();

  bool servicestatus = false;
  bool haspermission = false;
  bool showList = false;
  bool onTapCheckIn = false;

  String check_in_time = "";
  String check_out_time = "";

  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";

  DateTime currentTime = DateTime.now();

  late StreamSubscription<Position> positionStream;

  var _bottomNavIndex = 0; // efault index of first screen
  DashboardBloc dashboardBloc = DashboardBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: dashboardBloc,
      listener: (context, state) {
        print(state);
        if (state is ClockInLoading) {
          EasyLoading.show(status: state.message);
        }

        if (state is ClockInError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
        if (state is ClockInSuccessful) {
          EasyLoading.dismiss();

          setState(() {
            showList = true;
            onTapCheckIn = true;
          });
          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_in_time = formattedDate;
        }

        if (state is ClockOutSuccessful) {
          EasyLoading.dismiss();
          print(state);
          setState(() {
            showList = false;
            onTapCheckIn = false;
          });
          String formattedDate = DateFormat('hh:mm:ss  a').format(currentTime);
          check_out_time = formattedDate;
        }
        if (state is ClockOutLoading) {
          EasyLoading.show(status: state.message);
        }

        if (state is ClockOutError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.white,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.w),
                    child: Text(
                      "Hello ${widget.supervisorName}" ?? '',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          EasyLoading.show(status: "Logging out...");
                          var storage = GetIt.instance<GlobalStorage>();
                          storage.removeToken();
                          await Future.delayed(const Duration(seconds: 3));
                          EasyLoading.dismiss();
                          EasyLoading.showToast("Logout success...");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          color: AppColors.black,
                          size: 25.sp,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          EasyLoading.show(status: "Logging out...");
                          var storage = GetIt.instance<GlobalStorage>();
                          storage.removeToken();
                          await Future.delayed(const Duration(seconds: 3));
                          EasyLoading.dismiss();
                          EasyLoading.showToast("Logout success...");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          MydashboardScreenConstants.LOG_OUT,
                          style: TextStyle(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          body: SupervisorDashboardListWidget(
            onTapItem: (SupervisorModelDashboard data, bool isApproved) {
              print("templates " + isApproved.toString());
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TaskDetailsScreen(
                          isFromDashboard: true,
                          isFromFacility: false,
                          allocationId: data.taskAllocationId.toString() ?? '',
                          isApproved: isApproved,
                        )),
              );
            },
          )),
    );
  }
}
