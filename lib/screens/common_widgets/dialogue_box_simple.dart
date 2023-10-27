import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/white_button_widget.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';

class SimpleDialogueWidget extends StatefulWidget {
  final String text;
  final Function onTapSubmit;
  const SimpleDialogueWidget({
    Key? key,
    required this.text,
    required this.onTapSubmit,
  }) : super(key: key);

  @override
  State<SimpleDialogueWidget> createState() => _SimpleDialogueWidgetState();
}

class _SimpleDialogueWidgetState extends State<SimpleDialogueWidget> {
  final TextEditingController _controller = TextEditingController();

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                ),
                child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: AppColors.checkboxGreyBorder,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.cancel),
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: Container(
                  height: 115.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: AppColors.commentBoxBorder, width: 1.w),
                  ),
                  child: TextFormField(
                    expands: true,
                    keyboardType: TextInputType.text,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlign: TextAlign.start,
                    maxLines: null,
                    minLines: null,
                    controller: _controller,
                    style: TextStyle(
                      color: AppColors.containerBorder,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      hintText: MyTaskListConstants.HINT_TEXT,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      hintStyle: TextStyle(
                        color: AppColors.containerBorder,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.w,
                ),
                child: WhiteButtonWidget(
                  text: MyTaskListConstants.SUBMIT_BTN,
                  color: AppColors.buttonColor,
                  onTap: () {
                    widget.onTapSubmit();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
