import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LanguageGridItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageGridItem({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 10.w,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppColors.yellowCardColor : AppColors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: InkWell(
          onTap: () => onTap(),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}
