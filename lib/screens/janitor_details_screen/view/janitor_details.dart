import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

class JanitorDetails extends StatefulWidget {
  final int? id;
  const JanitorDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<JanitorDetails> createState() => _JanitorDetailsState();
}

class _JanitorDetailsState extends State<JanitorDetails> {
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
            MyJanitorsDetailsScreenConstants.APP_BAR,
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  child: Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreyColor),
                    child: const Icon(
                      Icons.person_2_outlined,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        "Uma Jadhav",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        "Mob.no. 9876543210 ",
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Container(
              height: 1.h,
              color: AppColors.dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.SHIFT,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "Morning",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.CHECK_IN,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "12th Mar, 08:12 AM",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.CHECK_OUT,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "12th Mar, 04:12 PM",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.COMPLETE_TASK,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "4",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.PENDING_TASK,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "2",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
              vertical: 6.h,
            ),
            child: Text(
              MyJanitorsDetailsScreenConstants.TOTAL_TASK,
              style: TextStyle(
                color: AppColors.greyTextColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.h,
            ),
            child: Text(
              "6",
              style: TextStyle(
                color: AppColors.black,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
