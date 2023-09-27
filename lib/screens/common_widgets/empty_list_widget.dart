import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/utils/app_images.dart';
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
            "Data Not Found ...",
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        )
      ],
    );
  }
}
