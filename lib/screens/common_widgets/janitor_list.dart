import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/common_widgets/empty_list_widget.dart';
import 'package:janitor/screens/janitor_screen/bloc/janitor_list_bloc.dart';
import 'package:janitor/screens/janitor_screen/bloc/janitor_list_event.dart';
import 'package:janitor/screens/janitor_screen/bloc/janitor_list_state.dart';
import 'package:janitor/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:janitor/screens/janitor_screen/data/model/Reassign_janitor_model.dart';
import 'package:janitor/screens/janitor_screen/view/janitor_screen.dart';
import 'package:janitor/screens/supervisor_dashboard/bloc/supervisor_dashboard_event.dart';
import 'package:janitor/screens/supervisor_dashboard/bloc/supervisor_dashboard_state.dart';
import 'package:janitor/screens/supervisor_dashboard/model/Supervisor_model_dashboard.dart';
import 'package:janitor/utils/app_constants.dart';
import 'package:janitor/utils/app_images.dart';

import '../../utils/app_color.dart';
import '../supervisor_dashboard/bloc/supervisor_dashboard_bloc.dart';
import 'error_widget.dart';

class JanitorListWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isFromCluster;
  final bool isFromDashboard;
  final bool isFromFacility;
  final Function onTapItem;
  final String? janitorId;
  List<String> allocationId;
  final String? clusterId;
  final bool isFromDashboardAssignment;

  JanitorListWidget({
    Key? key,
    required this.controller,
    required this.onTapItem,
    required this.isFromCluster,
    required this.isFromDashboard,
    required this.isFromFacility,
    required this.allocationId,
    this.janitorId,
    this.clusterId,
    required this.isFromDashboardAssignment,
  }) : super(key: key);

  @override
  State<JanitorListWidget> createState() => _JanitorListWidgetState();
}

class _JanitorListWidgetState extends State<JanitorListWidget> {
  int selectedCard = -1;

  JanitorListBloc _janitorListBloc = JanitorListBloc();

  List<JanitorListModel> _data = [];
  List<JanitorListModel> _search = [];
  List<SupervisorModelDashboard> _supervisorDashboardData = [];

  late SupervisorDashboardBloc _supervisorDashboardBloc;

  ReassignJanitorModel _reassignJanitorModel = ReassignJanitorModel();
  bool janitorListReloading = false;
  bool dashboardListReloading = false;

  @override
  void initState() {
    _supervisorDashboardBloc = SupervisorDashboardBloc();

    _janitorListBloc.add(GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
    print("allocation ====> ${widget.allocationId}");
    widget.controller.addListener(() {
      setState(() {
        if (widget.controller.text.isEmpty) {
          _search = _data;
          return;
        }

        _search = _data
            .where((element) =>
                element.name
                    ?.toLowerCase()
                    .contains(widget.controller.text.toLowerCase()) ??
                false)
            .toList();
      });
    });
    print(widget.isFromDashboard);
    print(widget.isFromDashboardAssignment);
    print("cluster---->${widget.isFromCluster}");
    print(widget.isFromFacility);
    print("assignment ---->${widget.isFromDashboardAssignment}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _janitorListBloc,
        listener: (context, state) {
          if (state is JanitorListSuccess) {
            EasyLoading.dismiss();

            setState(() {
              _data = state.data;
              _search = _data;
            });

            if (janitorListReloading) {
              setState(() {
                _data = state.data;
                _search = _data;
              });
            }

            if (widget.isFromFacility) {
              setState(() {
                _data.removeWhere((element) {
                  return element.id == widget.janitorId;
                });
                _search = _data;
              });
            }
          }

          if (state is ReassignTaskSuccessful) {
            EasyLoading.dismiss();

            if (widget.isFromCluster) {
              _janitorListBloc
                  .add(GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
              setState(() {
                janitorListReloading = true;
              });

              Navigator.pop(context);
              Navigator.pop(context);
            }
            if (widget.isFromDashboardAssignment) {
              _supervisorDashboardBloc.add(GetSupervisorDashboardData());
              setState(() {
                dashboardListReloading = true;
              });
              Navigator.pop(context);
            }
          }

          if (state is GetSupervisorDashboardDataSuccess) {
            EasyLoading.dismiss();
            setState(() {
              _supervisorDashboardData = state.data;
              print("GetSupervisorDashboardDataSuccess--->" +
                  _supervisorDashboardData.toString());
            });

            if (dashboardListReloading) {
              setState(() {
                _supervisorDashboardData = state.data;
                // _search = _supervisorDashboardData;
              });
            }
          }
        },
        builder: (context, state) {
          if (state is JanitorListLoading && _data.isEmpty) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is JanitorListError) {
            return CustomErrorWidget(error: state.error);
          }

          if (state is ReassignTaskLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is ReassignTaskError) {
            EasyLoading.dismiss();
            return CustomErrorWidget(error: state.error);
          }
          if (state is SupervisorDashboardLoading &&
              _supervisorDashboardData.isEmpty) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is SupervisorDashboardError) {
            EasyLoading.dismiss();
            print("SupervisorDashboardError--->" +
                _supervisorDashboardData.toString());

            return CustomErrorWidget(error: state.error);
          }

          if (state is GetSupervisorDashboardDataSuccess &&
              _supervisorDashboardData.isEmpty) {
            EasyLoading.dismiss();
            print("GetSupervisorDashboardDataSuccess--->" +
                _supervisorDashboardData.toString());

            return const EmptyListWidget();
          }
          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  _janitorListBloc
                      .add(GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
                },
              );
            },
            color: AppColors.buttonColor,
            child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: _search.length,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                ) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 7.h),
                    child: GestureDetector(
                      onTap: () {
                        widget.onTapItem(_search[index]);
                        setState(() {
                          selectedCard = index;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 5.h,
                          horizontal: 10.w,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.w,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCard == index
                              ? AppColors.containerColor
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.containerBorder,
                            width: 1.w,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.h, horizontal: 5.w),
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.darkGreyColor),
                                  child: const Icon(
                                    Icons.person_2_outlined,
                                    color: AppColors.buttonColor,
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: ScreenUtil().screenWidth - 120.w,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 2.h,
                                            ),
                                            child: Text(
                                              _search[index].name ?? '',
                                              style: TextStyle(
                                                color:
                                                    AppColors.janitorNameColor,
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (widget.isFromCluster ||
                                            widget
                                                .isFromDashboardAssignment) ...[
                                          _search[index].isPresent == true
                                              ? Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        AppImages
                                                            .janitor_present,
                                                        height: 20.h,
                                                        width: 20.w,
                                                      ),
                                                      Text(
                                                        MyJanitorsListScreenConstants
                                                            .JANITOR_PRESENT,
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .greenText,
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                      AppImages.janitor_absent,
                                                      height: 20.h,
                                                      width: 20.w,
                                                    ),
                                                    Text(
                                                      MyJanitorsListScreenConstants
                                                          .JANITOR_ABSENT,
                                                      style: TextStyle(
                                                          color:
                                                              AppColors.redText,
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                )
                                        ],
                                        if (widget.isFromFacility) ...[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: InkWell(
                                              onTap: () {
                                                _janitorListBloc.add(
                                                    ReassignTask(
                                                        id: widget.allocationId,
                                                        janitor_id:
                                                            _data[index].id ??
                                                                ''));
                                              },
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: AppColors.buttonColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 8.h,
                                                  ),
                                                  child: Text(
                                                    MyClusterListScreenConstants
                                                        .BTN_TEXT,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      "Mob.no. ${_search[index].mobile}" ?? '',
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      _search[index].clusterName ?? '',
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                      vertical: 2.h,
                                    ),
                                    child: Text(
                                      "Pin code : ${_search[index].pincode}" ??
                                          '',
                                      style: TextStyle(
                                        color: AppColors.clusterTitleColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 2.h,
                                        ),
                                        child: Text(
                                          "Total task :${_search[index].totalTaskCount}" ??
                                              '',
                                          style: TextStyle(
                                            color: AppColors.greenTextColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 2.h,
                                        ),
                                        child: Text(
                                          "Pending task : ${_search[index].pendingTaskCount}" ??
                                              '',
                                          style: TextStyle(
                                            color: AppColors.redTextColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (widget.isFromDashboardAssignment &&
                                      _search[index].isPresent == true) ...[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.w, vertical: 5.h),
                                      child: InkWell(
                                        onTap: () {
                                          _janitorListBloc.add(
                                            ReassignTask(
                                                id: widget.allocationId,
                                                janitor_id:
                                                    _data[index].id ?? ''),
                                          );
                                        },
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: AppColors.buttonColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 8.h,
                                            ),
                                            child: Text(
                                              MyClusterListScreenConstants
                                                  .BTN_TEXT,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          );
        });
  }
}
