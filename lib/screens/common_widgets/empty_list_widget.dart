import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.network(
          "https://lottie.host/4b3fa0b7-a7db-43a4-a9ca-25314e51fda5/8dZUcYbLEj.json",
          width: 130.w,
        ),
        Center(
          child: Text(
            "Nothing to show...",
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        )
      ],
    );
  }
}
