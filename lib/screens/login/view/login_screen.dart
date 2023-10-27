import 'dart:io';

import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:dio_log/overlay_draggable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/login/bloc/login_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/login/view/otp_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:get_it/get_it.dart';
import 'package:pinput/pinput.dart';

class LoginScreen extends StatefulWidget {
  final String? type;

  const LoginScreen({
    Key? key,
    this.type,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginPageState();
}

class LoginPageState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  bool _isHintShown = false;
  LoginBloc loginBloc = LoginBloc();
  GlobalStorage globalStorage = GetIt.instance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Platform.isAndroid) hideKeyboard(context);
        if (Platform.isIOS) hideKeyboard(context);
      },
      child: Scaffold(
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                  child: Form(
                    key: _loginFormKey,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textAlign: TextAlign.center,
                      controller: _controller,
                      validator: (value) => value == null
                          ? MyLoginConstants.MOBILE_VALIDATION
                          : null,
                      maxLength: 10,
                      decoration: InputDecoration(
                        isDense: true,
                        counterText: "",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide:
                              const BorderSide(color: AppColors.greyBoxBorder),
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
                SizedBox(
                  height: 30.h,
                ),
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
                          builder: (context) => OTPScreen(
                            phoneNumber: _controller.text,
                            loginBloc: loginBloc,
                            type: widget.type,
                          ),
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
                        globalStorage.saveMobileNumber(
                            accessMobileNumber: _controller.text ?? '');
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
          )),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
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
