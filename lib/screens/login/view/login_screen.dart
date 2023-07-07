import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/login/view/otp_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    height: 150.h,
                    alignment: Alignment.center,
                  ),
                ),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    MyLoginConstants.WELCOME_TEXT,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 24.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: Form(
                    key: _loginFormKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.center,
                      controller: _controller,
                      validator: (value) => value == null ? MyLoginConstants.MOBILE_VALIDATION : null,
                      maxLength: 10,
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: const BorderSide(color: AppColors.greyBoxBorder),
                        ),
                        hintText: MyLoginConstants.MOBILE_NO,
                        hintStyle: TextStyle(
                          color: AppColors.greyColorFields,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () async {
                    if (_loginFormKey.currentState?.validate() ?? false) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(phoneNumber: _controller.text),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 30.w,
                    ),
                    child: const ButtonWidget(
                      text: MyLoginConstants.SEND_OTP_BTN,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
