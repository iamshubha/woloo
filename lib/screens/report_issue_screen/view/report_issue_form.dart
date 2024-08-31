import 'dart:core';
import 'dart:core';
import 'dart:io';

import 'package:Woloo_Smart_hygiene/screens/common_widgets/button_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/custom_input_field.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/dialogue_box_issue_report.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/dropdown_dialogue.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/error_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/multiselect_dropdown.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/bloc/report_issue_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/bloc/report_issue_event.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/bloc/report_issue_state.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/data/model/Cluster_dropdown_model.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/data/model/facility_dropdown_model.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/data/model/Janitor_dropdown_model.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/data/model/report_issue_model.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/data/model/task_names_model.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/widget/view_image.dart';
import 'package:Woloo_Smart_hygiene/screens/task_list/data/model/task_list_model.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
  List<TaskNamesModels> templateNames = [];
  TaskListModel taskNames = TaskListModel();
  List<Tasks> tasks = [];
  List<String> taskIds = [];
  List<JanitorDropdownModel> janitorList = [];
  ReportIssueModel _reportIssueModel = ReportIssueModel();
  List<String> selectedIds = [];
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
              templateNames = state.data;
            });
          }
          if (state is GetJanitorsDropdownSuccess) {
            EasyLoading.dismiss();

            setState(() {
              janitorList = state.data;
            });
          }
          if (state is GetTasksListSuccess) {
            EasyLoading.dismiss();

            setState(() {
              taskNames = state.data;

              tasks = taskNames.tasks!;
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
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }
          if (state is GetClustersDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetClustersDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }
          if (state is GetFacilityDropdownLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is GetFacilityDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          // if (state is GetFacilityDropdownSuccess && (state.data.isEmpty)) {
          //   EasyLoading.dismiss();
          //   return const EmptyListWidget();
          // }
          if (state is GetTasksDropdownLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is GetTasksDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          if (state is GetJanitorsDropdownLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is GetJanitorsDropdownError) {
            return CustomErrorWidget(error: state.error);
          }

          if (state is GetTasksListLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is GetTasksListError) {
            return CustomErrorWidget(error: state.error);
          }
          if (state is ReportIssueLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
          }

          if (state is ReportIssueError) {
            return CustomErrorWidget(error: state.error);
          }

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
                    color: Colors.white,
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
                    MydashboardScreenConstants.REPORT_ISSUE.tr(),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      color: AppColors.yellowSplashColor,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                backgroundColor: AppColors.appbarBgColor,
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
                          MyReportIssueScreenConstants.CLUSTER_NAME.tr(),
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
                                  .tr()
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        child: Text(
                          MyReportIssueScreenConstants.FACILITY.tr(),
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
                                  .tr()
                              : null,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                          // vertical: 10.h,
                        ),
                        child: Text(
                          MyReportIssueScreenConstants.TEMPLATE_NAME.tr(),
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
                          items: templateNames,
                          itemAsString: (TaskNamesModels item) =>
                              item.templateName,
                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants
                                  .TEMPLATE_NAME_VALIDATION
                                  .tr()
                              : null,
                          onChanged: (TaskNamesModels item) {
                            reportIssueBloc
                                .add(GetAllTaskList(id: item.id ?? '0'));
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
                          MyReportIssueScreenConstants.TASK_NAME.tr(),
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
                        child: MultiselectDropDownDialog(
                          // key: Key(
                          //     '${_editProductModel.paymentMethodId?.firstOrNull?.label}T5'),
                          // selected: _editProductModel.paymentMethodId,
                          items: tasks,
                          itemAsString: (Tasks item) => item.taskName,
                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants
                                  .TASK_NAME_VALIDATION
                                  .tr()
                              : null,
                          onSaved: (List<Tasks> i) {
                            // selectedIds.add(i[1].taskId!);
                            selectedIds =
                                i.map((e) => e.taskId.toString()).toList();
                          },
                          onChanged: (List<Tasks> i) {
                            selectedIds =
                                i.map((e) => e.taskId.toString()).toList();
                            print(selectedIds);
                          },
                          // label: 'Template Name',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        child: Text(
                          MyReportIssueScreenConstants.DESCRIPTION.tr(),
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
                                  .DESCRIPTION_VALIDATION
                                  .tr(),
                            ),
                          ]),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        child: Text(
                          MyReportIssueScreenConstants.ASSIGN_TO.tr(),
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
                          items: janitorList,
                          itemAsString: (JanitorDropdownModel item) =>
                              item.name,
                          validator: (value) => value == null
                              ? MyReportIssueScreenConstants.ASSIGN_VALIDATION
                                  .tr()
                              : null,
                          onChanged: (JanitorDropdownModel item) {
                            // setState(() {
                             FocusScope.of(context).requestFocus(FocusNode());
                              janitorId = item.id!;
                              print("selectedTasks---->${selectedIds}");

                              print("janitorId --->" + janitorId.toString());
                            // });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.h,
                          vertical: 10.h,
                        ),
                        child: Text(
                          MyReportIssueScreenConstants.UPLOAD_PHOTO.tr(),
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
                            child: _file != null
                                ?

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    GestureDetector(
                                      onTap: (){
                                         Navigator.of(context).push( MaterialPageRoute(builder:  (context) {
                                             return  ViewImage(
                                              file: _file,
                                             );
                                         }, ) );
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGray1,
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              MyReportIssueScreenConstants
                                                  .VIEW_PHOTO
                                                  .tr(),
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .clusterTitleColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                    GestureDetector(
                                      onTap: (){
                                        _file = null;

                                        setState(() {});
                                      },
                                      child: Center(
                                        child: Container(
                                          height: 40.h,
                                          width: 130.w,
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGray1,
                                            borderRadius: BorderRadius.circular(
                                              10.r,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              MyReportIssueScreenConstants
                                                  .DELETE_PHOTO
                                                  .tr(),
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .clusterTitleColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                            // Center(
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //             borderRadius:
                            //                 BorderRadius.circular(10.r),
                            //           ),
                            //           child: ClipRRect(
                            //             borderRadius: BorderRadius.circular(
                            //               10.r,
                            //             ),
                            //             child: Image.file(
                            //               _file!,
                            //               width: ScreenUtil().screenWidth,
                            //               height: 80.h,
                            //               fit: BoxFit.cover,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                                :
                            GestureDetector(
                              onTap: () async {
                                _file = await pickFile(
                                  null,
                                  PickSource.CAMERA,
                                );
                                setState(() {});
                              },
                              child: Center(
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
                                                MyReportIssueScreenConstants
                                                    .CHOOSE_PHOTO
                                                    .tr(),
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

                          print("ids---->${selectedIds}");

                          if (_file != null) {
                            reportIssueBloc.add(ReportIssue(
                                template_id: templateId,
                                facility_id: facilityId,
                                janitor_id: janitorId,
                                description: _controller.text,
                                task_images: _file!,
                                taskList: selectedIds));
                          } else {
                            EasyLoading.showToast(MyReportIssueScreenConstants
                                .UPLOAD_IMG_TOAST
                                .tr());
                          }

                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 20.h),
                          child: ButtonWidget(
                              text: MySelfieScreenConstants.SUBMIT_BTN.tr()),
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
          throw '.$extension ${MyReportIssueScreenConstants.FILE_NOT_ALLOWED.tr()}';
        }

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
