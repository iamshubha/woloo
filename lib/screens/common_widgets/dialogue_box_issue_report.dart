import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/pop_up_buttons.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/white_button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/issue_list_screen/view/issue_list.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';

class DialogueWidget extends StatefulWidget {
  const DialogueWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DialogueWidget> createState() => _DialogueWidgetState();
}

class _DialogueWidgetState extends State<DialogueWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
      child: SizedBox(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 5.w,
            vertical: 20.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                  ),
                  child: Center(
                    child: Image.asset(
                      AppImages.submittedIcon,
                      height: 70.h,
                      width: 70.w,
                    ),
                  )),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Text(
                    MyReportIssueScreenConstants.POP_UP_TEXT,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20.sp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: PopUpButtonWidget(
                    text: "Done",
                    color: AppColors.buttonColor,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
