import 'dart:io';

import 'package:Woloo_Smart_hygiene/screens/common_widgets/white_button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/bloc/selfie_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/bloc/selfie_event.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/bloc/selfie_state.dart';
import 'package:Woloo_Smart_hygiene/screens/task_list/view/task_list_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/app_images.dart';

enum PickSource { CAMERA }

class SelfieScreen extends StatefulWidget {
  final bool isFromChooseFacility;
  final bool isFromTask;
  final int? templateId;
  final String allocationId;

  const SelfieScreen({
    Key? key,
    this.isFromChooseFacility = false,
    this.isFromTask = false,
    required this.templateId,
    required this.allocationId,
  }) : super(key: key);

  @override
  State<SelfieScreen> createState() => _SelfieScreenState();
}

class _SelfieScreenState extends State<SelfieScreen> {
  File? _file;
  SelfieBloc selfieBloc = SelfieBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:
       _file != null ?
      AppBar(
        toolbarHeight: 75,
        leadingWidth: 0,
        leading: const SizedBox(),
        backgroundColor: AppColors.appbarBgColor,
        title:    Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: ()async{
                _file = await pickFile(null, PickSource.CAMERA);
                setState(() {});
              },
              child: Image.asset(
                AppImages.repeat_icon,
                //"assets/images/irepeat.png",
              width: 40.h,
              ),
            ),

            GestureDetector(
              onTap: ()async{
                _file = null;
                      setState(() {

                       });
              },
              child: Image.asset(
                AppImages.delete_icon,
                //"assets/images/irepeat.png",
                width: 40.h,
              ),
            ),
            // IconButton(onPressed: (){
            //   _file = null;
            //   setState(() {
            //
            //   });
            // }, icon:   Icon( AppImages.repeat_icon,
            //   color: AppColors.red300,
            //   size: 40.h,
            // ) ),
          ],
        ),
      )
           : null
       ,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          SizedBox(
            height:
            _file != null ?
                20.h
                :
            180.h,
          ),
          _file != null
              ? Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                       SizedBox(
                         height: 20.h,
                       ),
                      Container(
                        height: 440.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            15.r,
                          ),
                          child: Image.file(
                            _file!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
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
                        icon: const Icon(
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
                        MySelfieScreenConstants.TITLE_TEXT.tr(),
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.h, horizontal: 20.w),
                        child: Text(
                          MySelfieScreenConstants.TITLE_SUBTEXT.tr(),
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
          _file != null
              ? BlocConsumer<SelfieBloc, SelfieState>(
                  bloc: selfieBloc,
                  listener: (context, state) async {
                    if (state is UploadSelfieLoading) {
                      EasyLoading.show(status: state.message);
                    }

                    if (state is UploadSelfieSuccessful) {
                      EasyLoading.dismiss();
                      // Navigator.pop(context);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TaskList(
                              allocationId: widget.allocationId,
                              templateId: widget.templateId,
                            ),
                          ));
                    }

                    if (state is UploadSelfieError) {
                      EasyLoading.dismiss();
                      EasyLoading.showError(state.error);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 15.h,
                        horizontal: 30.w,
                      ),
                      child: WhiteButtonWidget(
                        text: MyTaskListConstants.SUBMIT_BTN.tr(),
                        color: AppColors.buttonColor,
                        onTap: () {
                          print("image#######" + _file!.path);

                          selfieBloc.add(UploadSelfie(
                            type: MySelfieScreenConstants.IMAGE_TYPE_SELFIE,
                            image: _file!,
                            id: widget.allocationId,
                            remarks: MySelfieScreenConstants.REMARKS,
                          ));
                        },
                      ),
                    );
                  })
              : Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 30.w,
                  ),
                  child: WhiteButtonWidget(
                    text: MyTaskListConstants.SUBMIT_BTN.tr(),
                    color: AppColors.disabledYellowButtonColor,
                    onTap: () {},
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
        throw MyReportIssueScreenConstants.FILE_NOT_SELECTED.tr();
      }
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
    return null;
  }
}
