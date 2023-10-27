import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';

class WhiteButtonWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Function onTap;

  const WhiteButtonWidget({
    Key? key,
    required this.text,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  State<WhiteButtonWidget> createState() => _WhiteButtonWidgetState();
}

class _WhiteButtonWidgetState extends State<WhiteButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 56.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
