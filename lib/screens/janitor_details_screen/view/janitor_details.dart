import 'package:Woloo_Smart_hygiene/screens/janitor_details_screen/view/sup_jani_attendance_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';

import '../../common_widgets/image_provider.dart';

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

  const JanitorDetails({
    super.key,
    required this.id,
    required this.shift,
    required this.name,
    required this.mobile,
    required this.check_in_time,
    required this.check_out_time,
    required this.complete_task,
    required this.pending_task,
    required this.total_task,
    required this.isPresent,
  });

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
            color: Colors.white,
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
            MyJanitorsDetailsScreenConstants.APP_BAR.tr(),
            textAlign: TextAlign.start,
            style:
            AppTextStyle.font24.copyWith(
              color: AppColors.yellowSplashColor, 
            )
            // TextStyle(
            //   color: AppColors.yellowSplashColor,
            //   fontSize: 24.sp,
            //   fontWeight: FontWeight.w400,
            // ),
          ),
        ),
        backgroundColor: AppColors.appbarBgColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 20.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 40.h,
                    width: 40.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.darkGreyColor),
                    child: const Icon(
                      Icons.person_2_outlined,
                      color: AppColors.buttonColor,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          AppTextStyle.font18.copyWith(
                              color: AppColors.black,
                          )
                          //  TextStyle(
                          //   color: AppColors.black,
                          //   fontSize: 18.sp,
                          //   fontWeight: FontWeight.w400,
                          // ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          widget.mobile,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                          AppTextStyle.font14.copyWith(
                            color: Colors.grey,
                          )
                          //  TextStyle(
                          //   color: Colors.grey,
                          //   fontSize: 14.sp,
                          //   fontWeight: FontWeight.w400,
                          // ),
                        ),
                      ],
                    ),
                  ),
                  widget.isPresent == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageProvider(
                              image: AppImages.janitor_present,
                              height: 20.h,
                              width: 20.w,
                            ),
                            Text(
                              MyJanitorsListScreenConstants.JANITOR_PRESENT,
                              style:
                              AppTextStyle.font12.copyWith(
                                color: AppColors.greenText,
                              )
                              //  TextStyle(
                              //     color: AppColors.greenText,
                              //     fontSize: 12.sp,
                              //     fontWeight: FontWeight.w400),
                            )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomImageProvider(
                              image: AppImages.janitor_absent,
                              height: 20.h,
                              width: 20.w,
                            ),
                            Text(
                              MyJanitorsListScreenConstants.JANITOR_ABSENT.tr(),
                              style:AppTextStyle.font12.copyWith(
                                color: AppColors.redText,
                              )
                              // TextStyle(
                              //     color: AppColors.redText,
                              //     fontSize: 12.sp,
                              //     fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                  SizedBox(width: 20.w),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SupJaniAttendanceScreen(
                              janiId: int.parse(widget.id)),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.history),
                        Text(
                          MyJanitorProfileScreenConstants.HISTORY.tr(),
                          style: 
                          AppTextStyle.font12.copyWith(
                                // color: AppColors.redText,
                              )
                          // TextStyle(
                          //   fontSize: 12.sp,
                          //   fontWeight: FontWeight.w400,
                          // ),
                        )
                      ],
                    ),
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
                MyJanitorsDetailsScreenConstants.SHIFT.tr(),
                style:
                AppTextStyle.font18.copyWith(
                  color: AppColors.greyTextColor,
                )
                //  TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.shift,
                style: 
                 AppTextStyle.font20.copyWith(
                  color: AppColors.black,
                )
                // TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 6.h,
              ),
              child: Text(
                "${MyJanitorsDetailsScreenConstants.CHECK_IN.tr()} :",
                style:
                  AppTextStyle.font18.copyWith(
                    color: AppColors.greyTextColor,
                )
                //  TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.check_in_time,
                style: 
                AppTextStyle.font20.copyWith(
                   color: AppColors.black,
                )
                // TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 6.h,
              ),
              child: Text(
                "${MyJanitorsDetailsScreenConstants.CHECK_OUT.tr()} :",
                style:
                AppTextStyle.font18.copyWith(
                   color: AppColors.greyTextColor,
                )
                //  TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.check_out_time,
                style:
                AppTextStyle.font20.copyWith(
                   color: AppColors.black,
                )
                //  TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 6.h,
              ),
              child: Text(
                "${MyJanitorsDetailsScreenConstants.COMPLETE_TASK.tr()} :",
                style: 
                AppTextStyle.font18.copyWith(
                   color: AppColors.greyTextColor,
                )
                // TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.complete_task,
                style:
                AppTextStyle.font20.copyWith(
                  color: AppColors.black,
                )
                //  TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 6.h,
              ),
              child: Text(
                "${MyJanitorsDetailsScreenConstants.PENDING_TASK.tr()} :",
                style: 
                AppTextStyle.font18.copyWith(
                  color: AppColors.greyTextColor,
                )
                // TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.pending_task,
                style:
                 AppTextStyle.font20.copyWith(
                  color: AppColors.black,
                )
                //  TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 6.h,
              ),
              child: Text(
                "${MyJanitorsDetailsScreenConstants.TOTAL_TASK.tr()} :",
                style:
                AppTextStyle.font18.copyWith(
                  color: AppColors.greyTextColor,
                )
                //  TextStyle(
                //   color: AppColors.greyTextColor,
                //   fontSize: 18.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                widget.total_task,
                style: 
                 AppTextStyle.font20.copyWith(
                  color: AppColors.black,
                )
                // TextStyle(
                //   color: AppColors.black,
                //   fontSize: 20.sp,
                //   fontWeight: FontWeight.w400,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
