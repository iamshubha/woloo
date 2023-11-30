import 'dart:io';

import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/language_list_item.dart';
import 'package:easy_localization/easy_localization.dart';
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
  bool _isLanguangeSelected = false;
  bool _isSheetOpen = false;

  LoginBloc loginBloc = LoginBloc();
  GlobalStorage globalStorage = GetIt.instance();
  int? _selectedLanguage;
  final List<String> _languages = [
    MyLoginConstants.LANGUAGE_ENGLISH.tr(),
    MyLoginConstants.LANGUAGE_HINDI.tr(),
    MyLoginConstants.LANGUAGE_MARATHI.tr()
  ];
  final List<Locale> _locales = const [
    Locale('en', 'US'),
    Locale('hi', 'IN'),
    Locale('mr', 'IN'),
  ];

  @override
  void initState() {
    super.initState();
    _settingModalBottomSheet(context);
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
                    MyLoginConstants.WELCOME_TEXT.tr(),
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
                          ? MyLoginConstants.MOBILE_VALIDATION.tr()
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
                        hintText: MyLoginConstants.MOBILE_NO.tr(),
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
                        child: ButtonWidget(
                          text: MyLoginConstants.SEND_OTP_BTN.tr(),
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

  void openBottomSheet() {
    _settingModalBottomSheet(context);
  }

  void _settingModalBottomSheet(context) async {
    await Future.delayed(Duration.zero);

    showModalBottomSheet(
        context: context,
        isDismissible: false,
        builder: (BuildContext cont) {
          return Container(
            height: 150.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                color: AppColors.yellowIcon,
                width: 2,
              ),
              borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(20.0),
                  topRight: const Radius.circular(20.0)),
            ),
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                return LanguageGridItem(
                    isSelected: index == _selectedLanguage,
                    text: _languages[index].tr(),
                    onTap: () {
                      context.setLocale(_locales[index]);
                      Navigator.pop(context);
                    });
              },
            ),
          );
        });
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
