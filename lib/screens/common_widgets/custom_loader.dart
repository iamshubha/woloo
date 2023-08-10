import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/utils/app_images.dart';
import 'package:lottie/lottie.dart';

class CustomLoaderWidget extends StatefulWidget {
  final String message;

  const CustomLoaderWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<CustomLoaderWidget> createState() => _CustomLoaderWidgetState();
}

class _CustomLoaderWidgetState extends State<CustomLoaderWidget> {
  bool cancelButtonTap = false;
  bool yesButtonTap = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: LottieBuilder.asset(
              AppImages.loader_lottie,
              width: 200.w,
              height: 150.h,
            ),
          ),
          Center(
            child: Text(
              widget.message,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
