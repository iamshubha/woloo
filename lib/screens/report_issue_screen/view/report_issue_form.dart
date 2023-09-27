import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:janitor/screens/common_widgets/button_widget.dart';
import 'package:janitor/screens/common_widgets/custom_input_field.dart';
import 'package:janitor/screens/common_widgets/dialogue_box_issue_report.dart';
import 'package:janitor/screens/common_widgets/dropdown_dialogue.dart';
import 'package:janitor/screens/common_widgets/empty_list_widget.dart';
import 'package:janitor/screens/common_widgets/error_widget.dart';
import 'package:janitor/screens/report_issue_screen/bloc/report_issue_bloc.dart';
import 'package:janitor/screens/report_issue_screen/bloc/report_issue_event.dart';
import 'package:janitor/screens/report_issue_screen/bloc/report_issue_state.dart';
import 'package:janitor/screens/report_issue_screen/data/model/Cluster_dropdown_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/Janitor_dropdown_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/report_issue_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/task_names_model.dart';
import 'package:janitor/screens/report_issue_screen/data/model/facility_dropdown_model.dart';
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

  ReportIssueBloc reportIssueBloc = ReportIssueBloc();
  final TextEditingController _controller = TextEditingController();

  List<ClusterDropdownModel> clusterNames = [];
  List<FacilityDropdownModel> facilityNames = [];
  List<TaskNamesModels> taskNames = [];
  List<JanitorDropdownModel> janitorList = [];
  ReportIssueModel _reportIssueModel = ReportIssueModel();
  String templateId = "";
  late int janitorId;
  late int facilityId;
  late File taskImage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    reportIssueBloc.add(GetAllClustersDropdown());
    reportIssueBloc.add(GetAllTasksDropdown());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: reportIssueBloc,
        listener: (context, state) {
          if (state is GetClustersDropdownSuccess) {
            EasyLoading.dismiss();

            setState(() {
              clusterNames = state.data;
            });
          }
          if (state is GetFacilityDropdownSuccess) {
            EasyLoading.dismiss();

            setState(() {
              facilityNames = state.data;
            });
          }
          if (state is GetTasksDropdownSuccess) {
            EasyLoading.dismiss();

            setState(() {
              taskNames = state.data;
            });
          }
          if (state is GetJanitorsDropdownSuccess) {
            EasyLoading.dismiss();

            setState(() {
              janitorList = state.data;
            });
          }

          if (state is ReportIssueSuccess) {
            EasyLoading.dismiss();
            _reportIssueModel = state.data;
            openDialog();
            // EasyLoading.showToast(_reportIssueModel.message.toString());
          }
        },
        builder: (context, state) {
          if (state is GetClustersDropdownLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }
          if (state is GetClustersDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetClustersDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }
          if (state is GetFacilityDropdownLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is GetFacilityDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetFacilityDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }
          if (state is GetTasksDropdownLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is GetTasksDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetTasksDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }
          if (state is GetJanitorsDropdownLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is GetJanitorsDropdownError) {
            return CustomErrorWidget(error: state.error);
          }
          if (state is ReportIssueLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is ReportIssueError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetJanitorsDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }

          return GestureDetector(
            onTap: () {
              if (Platform.isAndroid) hideKeyboard(context);
              if (Platform.isIOS) hideKeyboard(context);
            },
            child: Scaffold(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 10.h),
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
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 10.h),
                        child: DropDownDialog(
                          // key: Key('${_editMarketModel.city?.label}T4'),
                          // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
                          // widgetKey: _keys[2],
                          items: clusterNames,
                          itemAsString: (ClusterDropdownModel item) =>
                              item.clusterName,
                          onChanged: (ClusterDropdownModel item) {
                            try {
                              reportIssueBloc.add(GetAllFacilityDropdown(
                                  clusterId: item.clusterId ?? 0));
                              reportIssueBloc.add(GetAllJanitorsDropdown(
                                  clusterId: item.clusterId ?? 0));
                            } catch (e) {
                              print("dropppppp" + e.toString());
                            }
                          },

                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants
                                  .CLUSTER_NAME_VALIDATION
                              : null,
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
                          items: facilityNames,
                          itemAsString: (FacilityDropdownModel item) =>
                              item.facilityName,

                          onChanged: (FacilityDropdownModel item) {
                            setState(() {
                              facilityId = item.id!;
                              print("facilityId --->" + facilityId.toString());
                            });
                          },
                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants.FACILITY_VALIDATION
                              : null,
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
                          items: taskNames,
                          itemAsString: (TaskNamesModels item) =>
                              item.templateName,
                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants
                                  .TASK_NAME_VALIDATION
                              : null,
                          onChanged: (TaskNamesModels item) {
                            setState(() {
                              templateId = item.id!;
                              print("templateId --->" + templateId.toString());
                            });
                          },
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
                          controller: _controller,

                          validator: qValidator([
                            IsRequired(
                              MyReportIssueScreenConstants
                                  .DESCRIPTION_VALIDATION,
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
                          items: janitorList,
                          itemAsString: (JanitorDropdownModel item) =>
                              item.name,

                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants.ASSIGN_VALIDATION
                              : null,
                          onChanged: (JanitorDropdownModel item) {
                            setState(() {
                              janitorId = item.id!;
                              print("janitorId --->" + janitorId.toString());
                            });
                          },
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
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                _file = await pickFile(
                                  null,
                                  PickSource.CAMERA,
                                );
                                setState(() {});
                              },
                              child: _file != null
                                  ? Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                          child: Image.file(
                                            _file!,
                                            width: ScreenUtil().screenWidth,
                                            height: 80.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: Container(
                                        height: 40.h,
                                        width: 140.w,
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGray1,
                                          borderRadius: BorderRadius.circular(
                                            10.r,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                                  color: AppColors
                                                      .clusterTitleColor,
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
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          bool isValid =
                              _formKey.currentState?.validate() ?? false;
                          if (!isValid) {
                            return;
                          }
                          if (_file != null) {
                            reportIssueBloc.add(ReportIssue(
                                template_id: templateId,
                                facility_id: facilityId,
                                janitor_id: janitorId,
                                description: _controller.text,
                                task_images: _file!));
                          } else {
                            EasyLoading.showToast(
                                "Please upload an image to proceed");
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 20.h),
                          child: ButtonWidget(text: "Submit"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  openDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const DialogueWidget();
      },
    );
  }
}
