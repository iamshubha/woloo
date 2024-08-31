import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';

class PopUpButtonWidget extends StatefulWidget {
  final String text;
  final Color color;
  final Function onTap;

  const PopUpButtonWidget(
      {Key? key, required this.text, required this.color, required this.onTap})
      : super(key: key);

  @override
  State<PopUpButtonWidget> createState() => _PopUpButtonWidgetState();
}

class _PopUpButtonWidgetState extends State<PopUpButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        height: 40.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r), color: widget.color),
        child: Center(
          child: Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.black,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }
}
