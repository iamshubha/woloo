import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/common_widgets/custom_input_field.dart';
import 'package:janitor/screens/common_widgets/dropdown_dialogue.dart';
import 'package:janitor/screens/report_issue_screen/model/ItemModel.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:queen_validators/queen_validators.dart';

enum PickSource {
  CAMERA,
  GALLERY,
}

class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  File? _file;

  final List<ItemModel> _list = [
    ItemModel(
      value: 0,
      label: "Issue",
    ),
    ItemModel(
      value: 1,
      label: "Refill Hand Lotion",
    ),
    ItemModel(
      value: 2,
      label: "Refill Feminine Hygiene",
    ),
    ItemModel(
      value: 3,
      label: "Wipe sink and Fittings",
    ),
    ItemModel(
      value: 4,
      label: "Empty trash",
    ),
    ItemModel(
      value: 5,
      label: "Cleaning Floors",
    ),
    ItemModel(
      value: 6,
      label: "wipe Toilets",
    ),
    ItemModel(
      value: 7,
      label: "Wipe Mirror",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          color: AppColors.appBarIconColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
            vertical: 10.h,
          ),
          child: Text(
            MydashboardScreenConstants.REPORT_ISSUE,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: AppColors.appBarTitleColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.CLUSTER_NAME,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: DropDownDialog(
                // key: Key('${_editMarketModel.city?.label}T4'),
                // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
                // widgetKey: _keys[2],
                items: _list,
                itemAsString: (ItemModel item) => item.label,

                validator: (value) => value == null ? MyReportIssueScreenConstants.CLUSTER_NAME_VALIDATION : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.FACILITY,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: DropDownDialog(
                // key: Key('${_editMarketModel.city?.label}T4'),
                // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
                // widgetKey: _keys[2],xx
                items: _list,
                itemAsString: (ItemModel item) => item.label,

                validator: (value) => value == null ? MyReportIssueScreenConstants.FACILITY_VALIDATION : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.TASK_NAME,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: DropDownDialog(
                // key: Key('${_editMarketModel.city?.label}T4'),
                // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
                // widgetKey: _keys[2],
                items: _list,
                itemAsString: (ItemModel item) => item.label,

                validator: (value) => value == null ? MyReportIssueScreenConstants.TASK_NAME_VALIDATION : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.DESCRIPTION,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: CustomInputField(
                // key: Key('${_editMarketModel.marketName}T1'),
                // initialValue: _editMarketModel.marketName,
                validator: qValidator([
                  IsRequired(
                    MyReportIssueScreenConstants.DESCRIPTION_VALIDATION,
                  ),
                ]),
                // onSaved: (value) => _createMarketModel.marketName = value,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.ASSIGN_TO,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              child: DropDownDialog(
                // key: Key('${_editMarketModel.city?.label}T4'),
                // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
                // widgetKey: _keys[2],
                items: _list,
                itemAsString: (ItemModel item) => item.label,

                validator: (value) => value == null ? MyReportIssueScreenConstants.ASSIGN_VALIDATION : null,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.h,
                vertical: 10.h,
              ),
              child: Text(
                MyReportIssueScreenConstants.UPLOAD_PHOTO,
                style: TextStyle(
                  color: AppColors.clusterTitleColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: DottedBorder(
                color: Colors.black,
                borderType: BorderType.RRect,
                radius: Radius.circular(10.r),
                strokeWidth: 0.5.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 60.w,
                    vertical: 20.h,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      pickFile(
                        _file,
                        PickSource.GALLERY,
                      );
                    },
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightGray1,
                        borderRadius: BorderRadius.circular(
                          10.r,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Icon(
                              Icons.file_open_outlined,
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            child: Text(
                              "Choose file",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.clusterTitleColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 30.w,
                ),
                child: ButtonWidget(text: "Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<File?> pickFile(File? old, PickSource source) async {
    try {
      File? file;
      final List<String> allowedFileTypes = const ['jpg', 'png', 'jpeg'];

      if (source == PickSource.GALLERY) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: allowedFileTypes,
        );
        if (result != null) {
          file = File(result.files.first.path ?? '');
        }
      }

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
        String path = file.path;

        /// Check extension
        String extension = path.split('/').last.split(".").last;
        if (!allowedFileTypes.contains(extension)) {
          throw '.$extension file is not allowed.';
        }

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

  // Future<File?> pickFile(File? old, PickSource source) async {
  //   try {
  //     File? file;
  //     final List<String> allowedFileTypes = const ['jpg', 'png', 'jpeg'];
  //     if (source == PickSource.GALLERY) {
  //       FilePickerResult? result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: allowedFileTypes,
  //       );
  //       if (result != null) {
  //         file = File(result.files.first.path ?? '');
  //         EasyLoading.showToast(file.toString());
  //       }
  //     }
  //
  //     if (source == PickSource.CAMERA) {
  //       final ImagePicker _picker = ImagePicker();
  //       final XFile? photo = await _picker.pickImage(
  //         source: ImageSource.camera,
  //         imageQuality: 50,
  //       );
  //       if (photo != null) {
  //         file = File(photo.path);
  //         EasyLoading.showToast(file.toString());
  //       }
  //     }
  //
  //     if (file != null) {
  //       String path = file.path;
  //       EasyLoading.showToast(path);
  //
  //       /// Check extension
  //       String extension = path.split('/').last.split(".").last;
  //       if (!allowedFileTypes.contains(extension)) {
  //         throw '.$extension file is not allowed.';
  //       }
  //
  //       return file;
  //     }
  //
  //     if (old != null) {
  //       return old;
  //     }
  //
  //     if (old == null) {
  //       throw 'File not selected.';
  //     }
  //   } catch (e) {
  //     EasyLoading.showToast(e.toString());
  //   }
  //   return null;
  // }
}
