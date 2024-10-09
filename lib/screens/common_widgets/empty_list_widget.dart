import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(
          AppImages.empty_list_animation,
          width: 200.w,
          repeat: false,
        ),
        Center(
          child: Text(
            EmptyWidgetConstants.DATA_NOT_FOUND.tr(),
            style:
            AppTextStyle.font16
            //  TextStyle(
            //   fontSize: 16.sp,
            // ),
          ),
        )
      ],
    );
  }
}
