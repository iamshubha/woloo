import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';

class JanitorDetails extends StatefulWidget {
  final String id;
  final String shift;
  final String name;
  final String mobile;
  final String check_in_time;
  final String check_out_time;
  final String complete_task;
  final String pending_task;
  final String total_task;
  final bool isPresent;

  const JanitorDetails(
      {Key? key,
      required this.id,
      required this.shift,
      required this.name,
      required this.mobile,
      required this.check_in_time,
      required this.check_out_time,
      required this.complete_task,
      required this.pending_task,
      required this.total_task,
      required this.isPresent})
      : super(key: key);

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  child: Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.darkGreyColor),
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
                        horizontal: 5.w,
                        vertical: 5.h,
                      ),
                      child: Text(
                        widget.name ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                        vertical: 2.h,
                      ),
                      child: Text(
                        "Mob.no.${widget.mobile}" ?? '',
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                widget.isPresent == true
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.janitor_present,
                              height: 20.h,
                              width: 20.w,
                            ),
                            Text(
                              MyJanitorsListScreenConstants.JANITOR_PRESENT,
                              style: TextStyle(
                                  color: AppColors.greenText,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImages.janitor_absent,
                            height: 20.h,
                            width: 20.w,
                          ),
                          Text(
                            MyJanitorsListScreenConstants.JANITOR_ABSENT,
                            style: TextStyle(
                                color: AppColors.redText,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )
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
              widget.shift ?? '',
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
              widget.check_in_time ?? '',
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
              widget.check_out_time ?? '',
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
              widget.complete_task.toString() ?? '',
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
              widget.pending_task ?? '',
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
              widget.total_task ?? '',
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
