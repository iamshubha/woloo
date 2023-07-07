import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janitor/screens/common_widgets/white_button_widget.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

enum PickSource { CAMERA }

class TaskCompletionScreen extends StatefulWidget {
  // final bool isFromChooseFacility;
  // final bool isFromTask;
  const TaskCompletionScreen({
    Key? key,
    // this.isFromChooseFacility = false,
    // this.isFromTask = false,
  }) : super(key: key);

  @override
  State<TaskCompletionScreen> createState() => _TaskCompletionScreenState();
}

class _TaskCompletionScreenState extends State<TaskCompletionScreen> {
  File? _file;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180.h,
          ),
          _file != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Container(
                    height: 300.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Image.file(
                      _file!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )

              // Stack(
              //         children: <Widget>[
              //           Padding(
              //             padding: EdgeInsets.symmetric(
              //               horizontal: 20.w,
              //             ),
              //             child: Container(
              //               height: 300.h,
              //               decoration: BoxDecoration(
              //                 border: Border.all(
              //                   color: Colors.black,
              //                   width: 5.w,
              //                 ),
              //                 borderRadius: BorderRadius.circular(10.r),
              //               ),
              //               child: Image.file(
              //                 _file!,
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //           Positioned(
              //             top: 0,
              //             right: 0,
              //             child: GestureDetector(
              //               onTap: () {
              //                 print('delete image from List');
              //                 setState(() {
              //                   imageCache.clear();
              //                 });
              //               },
              //               child: Icon(
              //                 Icons.delete,
              //               ),
              //             ),
              //           ),
              //         ],
              //       )
              : Column(
                  children: [
                    Container(
                      height: 180.h,
                      width: 180.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.checkboxGreyBorder,
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.buttonColor,
                          size: 100,
                        ),
                        onPressed: () async {
                          _file = await pickFile(null, PickSource.CAMERA);
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                      ),
                      child: Text(
                        TaskCompletionScreenConstants.TITLE_TEXT,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                        child: Text(
                          TaskCompletionScreenConstants.TITLE_SUBTEXT,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
              horizontal: 30.w,
            ),
            child: WhiteButtonWidget(
              text: MyTaskListConstants.SUBMIT_BTN,
              color: AppColors.buttonColor,
              onTap: () {
                // if (widget.isFromChooseFacility) {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => TaskList(),
                //     ),
                //   );
                // }
                // if (widget.isFromTask) {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Dashboard(
                //         isFromJanitor: true,
                //         isFromSupervisor: false,
                //       ),
                //     ),
                //   );
                // }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<File?> pickFile(File? old, PickSource source) async {
    try {
      File? file;

      if (source == PickSource.CAMERA) {
        final ImagePicker _picker = ImagePicker();
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
          imageQuality: 50,
        );
        if (photo != null) {
          file = File(photo.path);
        }
      }

      if (file != null) {
        return file;
      }

      if (old != null) {
        return old;
      }

      if (old == null) {
        throw 'File not selected.';
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
    return null;
  }
}
