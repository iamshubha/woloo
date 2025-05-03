import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final IconData? prefixIcon;
  final Color fillColor;
  final FocusNode? focusNode;
  final bool? readOnly;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLength,
    this.validator,
    this.prefixIcon,
    this.fillColor = Colors.white,
    this.focusNode,
    this.readOnly =false

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: Container(
        // height: 36.h,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Shadow color
              spreadRadius: 1, // Spread effect
              blurRadius: 10, // Blur effect
              offset: const Offset(0, 5), // Bottom shadow
            ),
          ],
        ),
        child:
        TextFormField(
          readOnly:readOnly!,
          focusNode: focusNode,
          // onTapOutside: (event) {
          //   FocusScope.of(context).unfocus();
          // },
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLength: maxLength,
          validator: validator,
          // textAlign: TextAlign.center,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            isDense: true,
            counterText: "", // Removes character counter
            fillColor: fillColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.grey)
                : null,
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
          ),
        ),
      ),
    );
  }
}
