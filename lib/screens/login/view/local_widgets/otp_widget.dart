import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:pinput/pinput.dart';

class OTPWidget extends StatefulWidget {
  final Function onComplete;

  const OTPWidget({
    Key? key,
    required this.onComplete,
  }) : super(key: key);

  @override
  State<OTPWidget> createState() => _OTPWidgetState();
}

class _OTPWidgetState extends State<OTPWidget> {
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 30);
  bool _isTapResendEnabled = false;
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(
      myDuration.inSeconds.remainder(60),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Pinput(
            controller: _pinController,
            hapticFeedbackType: HapticFeedbackType.lightImpact,
            defaultPinTheme: PinTheme(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.greyBoxBorder,
                  width: 1.sp,
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            onCompleted: (pin) {
              print(pin);
              widget.onComplete(pin);
            },
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (_isTapResendEnabled) {
                    resetTimer();
                  }
                },
                child: Text(
                  MyLoginConstants.DIDNT_RECIEVED_OTP,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: AppColors.greyMap,
                  ),
                ),
              ),
              Text(
                '$seconds Sec',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),

        /// Show [Send OTP] button if OTP is not sent
      ],
    );
  }

  void startTimer() {
    setState(() {
      _isTapResendEnabled = false;
    });
    countdownTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setCountDown(),
    );
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    setState(
      () => myDuration = const Duration(seconds: 30),
    );
    startTimer();
  }

  // Step 6
  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(
      () {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
          _isTapResendEnabled = true;
        } else {
          myDuration = Duration(
            seconds: seconds,
          );
        }
      },
    );
  }
}
