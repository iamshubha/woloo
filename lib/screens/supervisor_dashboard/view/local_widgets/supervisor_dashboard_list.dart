import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/empty_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/error_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/view/janitor_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/bloc/supervisor_dashboard_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/bloc/supervisor_dashboard_event.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/bloc/supervisor_dashboard_state.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/model/Supervisor_model_dashboard.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

class SupervisorDashboardListWidget extends StatefulWidget {
  final Function onTapItem;

  const SupervisorDashboardListWidget({
    super.key,
    required this.onTapItem,
  });

  @override
  State<SupervisorDashboardListWidget> createState() =>
      _SupervisorDashboardListWidgetState();
}

class _SupervisorDashboardListWidgetState
    extends State<SupervisorDashboardListWidget> {
  int selectedCard = -1;
  late SupervisorDashboardBloc _supervisorDashboardBloc;
  List<SupervisorModelDashboard> _data = [];
  GlobalStorage globalStorage = GetIt.instance();
  bool isApproved = false;
  bool isSelected = false;
  late int supervisorId;

  @override
  void initState() {
    _supervisorDashboardBloc = SupervisorDashboardBloc();
    supervisorId = globalStorage.getId();
    _supervisorDashboardBloc.add(GetSupervisorDashboardData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _supervisorDashboardBloc,
      listener: (context, state) {
        if (state is GetSupervisorDashboardDataSuccess) {
          EasyLoading.dismiss();
          setState(() {
            _data = state.data;
            print("GetSupervisorDashboardDataSuccess--->" + _data.toString());
          });
        }
        if (state is SupervisorUpdateStatusSuccessful) {
          EasyLoading.dismiss();
          setState(() {
            isApproved = true;
          });
          print("SupervisorUpdateStatusSuccessful " + isApproved.toString());
        }

        // if (state is AssignTaskSuccessful) {
        //   EasyLoading.dismiss();
        //
        //   Navigator.pop(context);
        //   Navigator.pop(context);
        // }
      },
      builder: (context, state) {
        if (state is SupervisorDashboardLoading && _data.isEmpty) {
          EasyLoading.show(
              status: MydashboardScreenConstants.LOADING_TOAST.tr());
        }

        if (state is SupervisorDashboardError) {
          EasyLoading.dismiss();
          print("SupervisorDashboardError--->" + _data.toString());

          return CustomErrorWidget(error: state.error);
        }

        if (state is GetSupervisorDashboardDataSuccess && _data.isEmpty) {
          EasyLoading.dismiss();
          print("GetSupervisorDashboardDataSuccess--->" + _data.toString());

          return const EmptyListWidget();
        }
        if (state is SupervisorUpdateStatusLoading) {
          EasyLoading.show(
              status: MydashboardScreenConstants.LOADING_TOAST.tr());
        }

        if (state is SupervisorUpdateStatusError) {
          EasyLoading.dismiss();

          return CustomErrorWidget(error: state.error);
        }
        // if (state is AssignTaskLoading) {
        //   EasyLoading.show(status: __MydashboardScreenConstants.LOADING_TOAST.tr());
        // }
        //
        // if (state is AssignTaskError) {
        //   EasyLoading.dismiss();
        //   return CustomErrorWidget(error: state.error);
        // }

        return RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 1),
              () {
                _supervisorDashboardBloc.add(GetSupervisorDashboardData());
              },
            );
          },
          color: AppColors.buttonColor,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: _data.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 7.h,
                ),
                child: GestureDetector(
                  onTap: () {
                    widget.onTapItem(_data[index], isApproved);
                    setState(() {
                      selectedCard = index;
                    });
                  },
                  child: _data[index].status == "Completed"
                      ? Container(
                          // height: 240.h,
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 10.w,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.disabledContainerColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.containerBorder,
                              width: 1.w,
                            ),
                            // boxShadow: const [
                            //   BoxShadow(
                            //     blurRadius: 5,
                            //     spreadRadius: 1,
                            //     offset: Offset(0, 1),
                            //   ),
                            // ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15.sp,
                                          color: AppColors.containerBorder,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            _data[index].date ?? '',
                                            style: TextStyle(
                                              color: AppColors.containerBorder,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.access_time,
                                          size: 15.sp,
                                          color: AppColors.containerBorder,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            "${_data[index].startTime} - ${_data[index].endTime}" ??
                                                '',
                                            style: TextStyle(
                                              color: AppColors.containerBorder,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 5.h,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: getColorByRequestType(
                                                  _data[index].requestType ??
                                                      ''),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 20.w,
                                              ),
                                              child: Text(
                                                _data[index].requestType ==
                                                        "Customer Request"
                                                    ? "Customer"
                                                    : _data[index]
                                                            .requestType ??
                                                        '',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.containerBorder,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            (_data[index].status ?? '').tr(),
                                            style: TextStyle(
                                              color: getColorByStatus(
                                                  _data[index].status ?? ''),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 5.h,
                                            ),
                                            child: Text(
                                              _data[index].templateName ?? '',
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color:
                                                    AppColors.containerBorder,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 5.h),
                                              child: const Icon(
                                                Icons.access_time_filled,
                                                size: 20,
                                                color:
                                                    AppColors.containerBorder,
                                              ),
                                            ),
                                            Text(
                                              " ${_data[index].estimatedTime ?? ''}",
                                              style: TextStyle(
                                                color:
                                                    AppColors.containerBorder,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.h,
                                      ),
                                      child: Text(
                                        "${MydashboardScreenConstants.DESCRIPTION.tr()} : ${_data[index].description ?? ''}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: AppColors.containerBorder,
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
                                        "${MydashboardScreenConstants.DESCRIPTION.tr()} : ${_data[index].location ?? ''}",
                                        style: TextStyle(
                                          color: AppColors.containerBorder,
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
                                        "${MydashboardScreenConstants.BOOTHS.tr()}  :${_data[index].booths ?? ''}",
                                        style: TextStyle(
                                          color: AppColors.containerBorder,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                            "${MydashboardScreenConstants.TOTAL_TASK.tr()} : ${_data[index].totalTasks ?? ''}",
                                            style: TextStyle(
                                              color:
                                                  AppColors.disabledGreenColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                            "${MydashboardScreenConstants.PENDING_TASK.tr()}  : ${_data[index].pendingTasks ?? ''}",
                                            style: TextStyle(
                                              color: AppColors.disabledRedColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.person,
                                                color: AppColors.black,
                                                size: 15.sp,
                                                weight: 0.5),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.h,
                                              ),
                                              child: Text(
                                                _data[index].janitorName ?? '',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.containerBorder,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ))
                      : Container(
                          // height: 240.h,
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 10.w,
                          ),
                          margin: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.containerBorder,
                              width: 1.w,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15.sp,
                                          color: AppColors.timeSlotColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            _data[index].date ?? '',
                                            style: TextStyle(
                                              color: AppColors.timeSlotColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.access_time,
                                          size: 15.sp,
                                          color: AppColors.timeSlotColor,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            "${_data[index].startTime} - ${_data[index].endTime}" ??
                                                '',
                                            style: TextStyle(
                                              color: AppColors.timeSlotColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 5.h,
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: getColorByRequestType(
                                                  _data[index].requestType ??
                                                      ''),
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 5.h,
                                                horizontal: 20.w,
                                              ),
                                              child: Text(
                                                _data[index].requestType ==
                                                        "Customer Request"
                                                    ? "Customer"
                                                    : _data[index]
                                                            .requestType ??
                                                        '',
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.8,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            (_data[index].status ?? '').tr(),
                                            style: TextStyle(
                                              color: getColorByStatus(
                                                  _data[index].status ?? ''),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 5.h,
                                            ),
                                            child: Text(
                                              _data[index].templateName ?? '',
                                              maxLines: 1,
                                              softWrap: false,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.ListTitleColor,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 5.h),
                                              child: const Icon(
                                                Icons.access_time_filled,
                                                size: 20,
                                                color: AppColors.ListTitleColor,
                                              ),
                                            ),
                                            Text(
                                              _data[index]
                                                      .estimatedTime
                                                      .toString() ??
                                                  '',
                                              style: TextStyle(
                                                color: AppColors.ListTitleColor,
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 1.h,
                                      ),
                                      child: Text(
                                        "${MydashboardScreenConstants.DESCRIPTION.tr()} : ${_data[index].description ?? ''}",
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: AppColors.ListTitleColor,
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
                                        "${MydashboardScreenConstants.LOCATION.tr()} : ${_data[index].location ?? ''}",
                                        style: TextStyle(
                                          color: AppColors.ListTitleColor,
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
                                        "${MydashboardScreenConstants.BOOTHS.tr()}  :${_data[index].booths ?? ''}",
                                        style: TextStyle(
                                          color: AppColors.ListTitleColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                            "${MydashboardScreenConstants.TOTAL_TASK.tr()}  : ${_data[index].totalTasks ?? ''}",
                                            style: TextStyle(
                                              color: AppColors.greenTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                            "${MydashboardScreenConstants.PENDING_TASK.tr()}  : ${_data[index].pendingTasks ?? ''}",
                                            style: TextStyle(
                                              color: AppColors.redTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.person,
                                                color: AppColors.black,
                                                size: 15.sp,
                                                weight: 0.5),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.h,
                                              ),
                                              child: Text(
                                                _data[index].janitorName ?? '',
                                                style: TextStyle(
                                                  color: AppColors
                                                      .janitorNameColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (_data[index].status ==
                                            "Request for closure")
                                          InkWell(
                                            onTap: () {
                                              _supervisorDashboardBloc.add(
                                                  SupervisorUpdateStatus(
                                                      id: _data[index]
                                                              .taskAllocationId
                                                              .toString() ??
                                                          '',
                                                      status: 4));
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 8.h),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: AppColors.buttonColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 40.w,
                                                    vertical: 6.h,
                                                  ),
                                                  child: Text(
                                                    MyTaskDetailsScreenConstants
                                                        .APPROVE_BUTTON
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (_data[index].status == "Pending" &&
                                                _data[index].requestType ==
                                                    "IOT" &&
                                                _data[index].janitorId ==
                                                    null ||
                                            _data[index].status == "Pending" &&
                                                _data[index].requestType ==
                                                    "Regular" &&
                                                _data[index].janitorId == null)
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      JanitorList(
                                                    isFromCluster: false,
                                                    isFromDashboard: false,
                                                    allocationId: [
                                                      _data[index]
                                                          .taskAllocationId
                                                          .toString()
                                                    ],
                                                    isFromDashboardAssignment:
                                                        true,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.w,
                                                  vertical: 8.h),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r),
                                                  color: AppColors.buttonColor,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 40.w,
                                                    vertical: 6.h,
                                                  ),
                                                  child: Text(
                                                    MyFacilityListConstants
                                                        .ASSIGN
                                                        .tr(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Color getColorByStatus(String status) {
    switch (status) {
      case "Request for closure":
        return AppColors.yellowTextColor;
      case "Completed":
        return AppColors.greenTextColor;
      case "Pending":
        return AppColors.pendingStatusColor;
      default:
        return Colors.black;
    }
  }

  Color getColorByRequestType(String requestType) {
    switch (requestType) {
      case "IOT":
        return AppColors.iotBackgroundColor;
      case "Regular":
        return AppColors.regularButtonColor;
      case "Issue":
        return AppColors.issueButtonColor;
      case "Customer Request":
        return AppColors.acceptButtonColor;
      default:
        return AppColors.white;
    }
  }
}
