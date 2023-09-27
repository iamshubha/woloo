import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janitor/screens/common_widgets/custom_dialogue_widget.dart';
import 'package:janitor/screens/common_widgets/white_button_widget.dart';
import 'package:janitor/screens/dashboard/view/dashboard_screen.dart';
import 'package:janitor/screens/washroom_image_screen/bloc/images_bloc.dart';
import 'package:janitor/screens/washroom_image_screen/bloc/images_event.dart';
import 'package:janitor/screens/washroom_image_screen/bloc/images_state.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';

enum PickSource { CAMERA }

class TaskCompletionScreen extends StatefulWidget {
  final String allocationId;

  const TaskCompletionScreen({Key? key, required this.allocationId})
      : super(key: key);

  @override
  State<TaskCompletionScreen> createState() => _TaskCompletionScreenState();
}

class _TaskCompletionScreenState extends State<TaskCompletionScreen> {
  File? _file1;
  File? _file2;
  File? _file3;
  ImagesBloc _imagesBloc = ImagesBloc();
  List<File> fileList = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ImagesBloc, ImagesState>(
        bloc: _imagesBloc,
        listener: (context, state) async {
          if (state is UploadImagesLoading) {
            EasyLoading.show(status: state.message);
          }

          if (state is UploadImagesSuccessful) {
            EasyLoading.dismiss();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Dashboard(),
              ),
              (route) => false,
            );
          }

          if (state is UploadImagesError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.h,
                        horizontal: 20.w,
                      ),
                      child: Text(
                        TaskCompletionScreenConstants.TITLE_TEXT,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _file1 != null
                                  ? Container(
                                      height: 135.h,
                                      width: 150.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10.0), //add border radius
                                        child: Image.file(
                                          _file1!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        _file1 = await pickFile(
                                            null, PickSource.CAMERA);
                                        fileList.add(_file1!);
                                        print("fileeeee1" + _file1.toString());
                                        setState(() {});
                                      },
                                      child: DottedBorder(
                                        color: AppColors.dottedBorderColor,
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10.r),
                                        strokeWidth: 0.8.w,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30.w,
                                            vertical: 40.h,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40,
                                                color:
                                                    AppColors.dottedBorderColor,
                                              ),
                                              Text(
                                                "Add Photo",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.sp,
                                                  color: AppColors
                                                      .imageScreenGreyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                              _file2 != null
                                  ? Container(
                                      height: 135.h,
                                      width: 150.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10.0), //add border radius
                                        child: Image.file(
                                          _file2!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        _file2 = await pickFile(
                                            null, PickSource.CAMERA);
                                        fileList.add(_file2!);

                                        print("fileeeee2" + _file2.toString());

                                        setState(() {});
                                      },
                                      child: DottedBorder(
                                        color: AppColors.dottedBorderColor,
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10.r),
                                        strokeWidth: 0.8.w,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30.w,
                                            vertical: 40.h,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40,
                                                color:
                                                    AppColors.dottedBorderColor,
                                              ),
                                              Text(
                                                "Add Photo",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.sp,
                                                  color: AppColors
                                                      .imageScreenGreyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 25.w,
                            vertical: 10.h,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _file3 != null
                                  ? Container(
                                      height: 135.h,
                                      width: 150.w,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            10.0), //add border radius
                                        child: Image.file(
                                          _file3!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        _file3 = await pickFile(
                                            null, PickSource.CAMERA);
                                        fileList.add(_file3!);

                                        print("fileeeee3" + _file3.toString());

                                        setState(() {});
                                      },
                                      child: DottedBorder(
                                        color: AppColors.dottedBorderColor,
                                        borderType: BorderType.RRect,
                                        radius: Radius.circular(10.r),
                                        strokeWidth: 0.8.w,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 30.w,
                                            vertical: 40.h,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                size: 40,
                                                color:
                                                    AppColors.dottedBorderColor,
                                              ),
                                              Text(
                                                "Add Photo",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.sp,
                                                  color: AppColors
                                                      .imageScreenGreyColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 10.h,
                      ),
                      child: Text(
                        TaskCompletionScreenConstants.REMARKS,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 10.h,
                      ),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: AppColors.dashedBorderColor,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 10.h,
                        ),
                        radius: Radius.circular(
                          10.r,
                        ),
                        child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 30.w,
                      ),
                      child: WhiteButtonWidget(
                        text: MyTaskListConstants.SUBMIT_BTN,
                        color: AppColors.buttonColor,
                        onTap: () {
                          openDialog();
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
              ),
            ),
          );
        });
  }

  openDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomDialogueWidget(
          text: MyTaskListConstants.POPUP_TITLE,
          onTapSubmit: () {
            _imagesBloc.add(UploadImages(
              type: TaskCompletionScreenConstants.IMAGE_TYPE_TASK,
              image: fileList,
              id: widget.allocationId,
              remarks: _controller.text ?? '',
              allocationId: widget.allocationId,
            ));
          },
          onTapCancel: () {
            Navigator.pop(context);
          },
        );
      },
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
