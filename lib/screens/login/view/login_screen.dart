import 'dart:io';

import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/login/bloc/login_bloc.dart';
import 'package:janitor/screens/login/view/otp_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _isHintShown = false;
  LoginBloc loginBloc = LoginBloc();

  @override
  void initState() {
    // TODO: implement initState
    showDebugBtn(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
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
                BlocConsumer<LoginBloc, LoginState>(
                  bloc: loginBloc,
                  listener: (context, state) {
                    if (state is LoginLoading) {
                      EasyLoading.show(status: state.message);
                    }

                    if (state is LoginOTPSent) {
                      EasyLoading.dismiss();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(phoneNumber: _controller.text, loginBloc: loginBloc),
                        ),
                      );
                    }

                    if (state is LoginError) {
                      EasyLoading.dismiss();
                      EasyLoading.showError(state.error);
                    }

                    if (state is LoginGetDataSuccess) {
                      EasyLoading.dismiss();
                      setState(() {
                        // _filter = state.data;

                        /// Show hint only one time
                        /// * Works only on android platform
                        if (!_isHintShown && Platform.isAndroid) {
                          requestHint();
                        }
                      });
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () async {
                        if (_loginFormKey.currentState?.validate() ?? false) {
                          loginBloc.add(SendOTP(
                            mobileNumber: _controller.text,
                          ));
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
                    );
                  },
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

  void requestHint() async {
    final res = await SmartAuth().requestHint(
      isPhoneNumberIdentifierSupported: true,
      isEmailAddressIdentifierSupported: false,
      showCancelButton: true,
    );
    _isHintShown = true;
    _controller.text = (res?.id ?? '');
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: _controller.text.length),
    );
  }
}
