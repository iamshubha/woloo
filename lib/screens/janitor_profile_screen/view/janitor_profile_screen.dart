import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/view/attendance_history_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/login_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class JanitorProfileScreen extends StatefulWidget {
  const JanitorProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<JanitorProfileScreen> createState() => JanitorProfileScreenState();
}

class JanitorProfileScreenState extends State<JanitorProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 25,
            ),
            color: AppColors.appBarIconColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            child: Text(
              MyJanitorProfileScreenConstants.MY_PROFILE.tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.appBarTitleColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AttendanceHistoryScreen()),
                    // (route) => false,
                  );
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.history_img,
                          height: 25.h,
                          width: 25.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              textAlign: TextAlign.start,
                              MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY
                                  .tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 40.w,
                        // ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  EasyLoading.show(
                      status: MyJanitorProfileScreenConstants.LOGGING_OUT_TOAST
                          .tr());
                  var storage = GetIt.instance<GlobalStorage>();
                  storage.removeToken();
                  storage.removeLocation();
                  storage.removeTime();
                  await Future.delayed(const Duration(seconds: 3));
                  EasyLoading.dismiss();
                  EasyLoading.showToast(MyJanitorProfileScreenConstants
                      .LOG_OUT_SUCCESS_TOAST
                      .tr());
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                      bottom: BorderSide(
                          width: 1.0.w, color: AppColors.greyBorderColor),
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.logout_img,
                          height: 25.h,
                          width: 25.w,
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              textAlign: TextAlign.start,
                              MyJanitorProfileScreenConstants.LOG_OUT.tr(),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
