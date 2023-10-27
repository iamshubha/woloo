import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceHistoryScreen> createState() =>
      AttendanceHistoryScreenState();
}

class AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
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
              size: 30,
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
              MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.appBarTitleColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
            child: Container(
          child: Text("Attendance History "),
        )

            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     SizedBox(
            //       height: 70.h,
            //     ),
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 20.w),
            //       child: Text(
            //         MyJanitorProfileScreenConstants.MY_PROFILE,
            //         style: TextStyle(
            //           fontWeight: FontWeight.w400,
            //           fontSize: 20.sp,
            //           color: AppColors.darkGreyText,
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 30.h,
            //     ),
            //     GestureDetector(
            //       onTap: (){
            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => LoginScreen()),
            //               (route) => false,
            //         );
            //       },
            //       child: Container(
            //         height: 60.h,
            //         decoration: BoxDecoration(
            //           // color: AppColors.greyBgColor,
            //           border: Border(
            //             // bottom: BorderSide(
            //             //     width: 1.0.w, color: AppColors.greyBorderColor),
            //             top: BorderSide(
            //                 width: 1.0.w, color: AppColors.greyBorderColor),
            //           ),
            //         ),
            //         child: Padding(
            //           padding:
            //           EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
            //           child: Row(
            //             children: [
            //               Image.asset(
            //                 AppImages.history_img,
            //                 height: 25.h,
            //                 width: 25.w,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
            //                 child: Text(
            //                   textAlign: TextAlign.center,
            //                   MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY,
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 16.sp,
            //                     color: AppColors.black,
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 40.w,
            //               ),
            //               Icon(
            //                 Icons.arrow_forward_ios,
            //                 color: Colors.black,
            //                 size: 20,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     GestureDetector(
            //       onTap: () async {
            //         EasyLoading.show(status: "Logging out...");
            //         var storage = GetIt.instance<GlobalStorage>();
            //         storage.removeToken();
            //         storage.removeFCMToken();
            //         storage.removeLocation();
            //         storage.removeTime();
            //         await Future.delayed(const Duration(seconds: 3));
            //         EasyLoading.dismiss();
            //         EasyLoading.showToast("Logout success...");
            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => LoginScreen()),
            //               (route) => false,
            //         );
            //       },
            //       child: Container(
            //         height: 60.h,
            //         decoration: BoxDecoration(
            //           border: Border(
            //             top: BorderSide(
            //                 width: 1.0.w, color: AppColors.greyBorderColor),
            //             bottom: BorderSide(
            //                 width: 1.0.w, color: AppColors.greyBorderColor),
            //           ),
            //         ),
            //         child: Padding(
            //           padding:
            //           EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
            //           child: Row(
            //             children: [
            //               Image.asset(
            //                 AppImages.logout_img,
            //                 height: 25.h,
            //                 width: 25.w,
            //               ),
            //               Padding(
            //                 padding: EdgeInsets.symmetric(horizontal: 20.w),
            //                 child: Text(
            //                   textAlign: TextAlign.center,
            //                   MyJanitorProfileScreenConstants.LOG_OUT,
            //                   style: TextStyle(
            //                     fontWeight: FontWeight.w400,
            //                     fontSize: 16.sp,
            //                     color: AppColors.black,
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 100.h,
            //     ),
            //     GestureDetector(
            //       onTap: () async {
            //         EasyLoading.show(status: "Logging out...");
            //         var storage = GetIt.instance<GlobalStorage>();
            //         storage.removeToken();
            //         storage.removeFCMToken();
            //         storage.removeLocation();
            //         storage.removeTime();
            //         await Future.delayed(const Duration(seconds: 3));
            //         EasyLoading.dismiss();
            //         EasyLoading.showToast("Logout success...");
            //         Navigator.pushAndRemoveUntil(
            //           context,
            //           MaterialPageRoute(builder: (context) => LoginScreen()),
            //               (route) => false,
            //         );
            //       },
            //       child: Padding(
            //         padding: EdgeInsets.symmetric(
            //           vertical: 10.h,
            //           horizontal: 30.w,
            //         ),
            //         child: const ButtonWidget(
            //           text: MydashboardScreenConstants.LOG_OUT,
            //         ),
            //       ),
            //     ),
            //     SizedBox(
            //       height: 20.h,
            //     ),
            //   ],
            // ),
            ));
  }
}
