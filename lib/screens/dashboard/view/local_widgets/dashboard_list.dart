import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/common_widgets/empty_list_widget.dart';
import 'package:janitor/screens/common_widgets/error_widget.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_event.dart';
import 'package:janitor/screens/dashboard/bloc/dashboard_state.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model.dart';
import 'package:janitor/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:janitor/screens/selfie_screen/view/selfie_screen.dart';
import 'package:janitor/screens/washroom_image_screen/view/task_completion_screen.dart';
import 'package:janitor/utils/app_color.dart';
import 'package:janitor/utils/date_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardListWidget extends StatefulWidget {
  final Function onTapItem;
  final current_lattitude;
  final current_longitude;
  const DashboardListWidget({
    Key? key,
    required this.onTapItem,
    required this.current_lattitude,
    required this.current_longitude,
  }) : super(key: key);

  @override
  State<DashboardListWidget> createState() => _DashboardListWidgetState();
}

class _DashboardListWidgetState extends State<DashboardListWidget> {
  int selectedCard = -1;
  late DashboardBloc _dashboardBloc;
  List<DashboardModelClass> _data = [];
  late Double facility_lattitude;
  late Double facility_longitude;
  late Uri _url;

  GlobalStorage globalStorage = GetIt.instance();
  bool isSelected = false;

  final List<DashboardModel> _list = [
    DashboardModel(
      id: 0,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: Rest room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "In Progress",
      type: 'IOT',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
    DashboardModel(
      id: 1,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Pending",
      type: 'Regular',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
    DashboardModel(
      id: 2,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Accepted",
      type: 'Issue',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
    DashboardModel(
      id: 3,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: PWD Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Re-open",
      type: "Customer",
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
    DashboardModel(
      id: 4,
      name: "Gents Rest Room",
      description: 'Description: Gents Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Completed",
      type: 'Customer',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
    DashboardModel(
      id: 5,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 2',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Pending",
      type: 'Issue',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
    ),
  ];

  late int janitorId;

  @override
  void initState() {
    _dashboardBloc = DashboardBloc();
    janitorId = globalStorage.getId();
    _dashboardBloc.add(GetTaskTamplates(janitorId: janitorId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _dashboardBloc,
        listener: (context, state) {
          if (state is GetDashboardDataSuccess) {
            EasyLoading.dismiss();
            setState(() {
              _data = state.data;
            });
          }

          if (state is UpdateStatusSuccessful) {
            EasyLoading.dismiss();
            print("status updated");
          }
        },
        builder: (context, state) {
          if (state is DashboardLoading && _data.isEmpty) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is DashboardError) {
            return CustomErrorWidget(error: state.error);
          }
          if (state is UpdateStatusError) {
            return CustomErrorWidget(error: state.error);
          }
          if (state is UpdateStatusLoading) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is GetDashboardDataSuccess && state.data.isEmpty) {
            EasyLoading.dismiss();
            return const EmptyListWidget();
          }

          return ListView.builder(
              physics: const BouncingScrollPhysics(),
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
                        widget.onTapItem();
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
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                "${_data[index].startTime}-${_data[index].endTime}",
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 5.h,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.disabledbuttonColor,
                                                    borderRadius: BorderRadius.circular(
                                                      10.r,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 5.h,
                                                    horizontal: 20.w,
                                                  ),
                                                  child: Text(
                                                    _data[index].requestType == "Customer request" ? "Customer" : _data[index].requestType ?? '',
                                                    style: TextStyle(
                                                      color: AppColors.containerBorder,
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
                                                _data[index].status == "Ongoing" ? "In Progress" : _data[index].status ?? '',
                                                style: TextStyle(
                                                  color: _data[index].status == "Ongoing"
                                                      ? AppColors.inProgressStatusColor
                                                      : _data[index].status == "Pending"
                                                          ? AppColors.pendingStatusColor
                                                          : _data[index].status == "Accepted"
                                                              ? AppColors.greenTextColor
                                                              : _data[index].status == "Re-open"
                                                                  ? AppColors.reOpenStatusColor
                                                                  : _data[index].status == "Completed"
                                                                      ? AppColors.greenTextColor
                                                                      : Colors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 5.h,
                                          ),
                                          child: Text(
                                            "Classic cleaning",
                                            maxLines: 2,
                                            style: TextStyle(
                                              color: AppColors.containerBorder,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 1.h,
                                          ),
                                          child: Text(
                                            "Customer Name : Amol Jagtap",
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
                                            "Pimple Nilakh",
                                            maxLines: 2,
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
                                            "Pin Code : 441256",
                                            style: TextStyle(
                                              color: AppColors.containerBorder,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
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
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.center,
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
                                                CustomDateUtils.formatDate(_data[index].date ?? ''),
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
                                                "${_data[index].startTime}-${_data[index].endTime}",
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
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 5.h,
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: _data[index].requestType == "IOT"
                                                        ? AppColors.iotBackgroundColor
                                                        : _data[index].requestType == "Regular"
                                                            ? AppColors.regularButtonColor
                                                            : _data[index].requestType == "Issues"
                                                                ? AppColors.issueButtonColor
                                                                : _data[index].requestType == "Customer Request"
                                                                    ? AppColors.acceptButtonColor
                                                                    : AppColors.white,
                                                    borderRadius: BorderRadius.circular(
                                                      10.r,
                                                    )),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 5.h,
                                                    horizontal: 20.w,
                                                  ),
                                                  child: Text(
                                                    _data[index].requestType == "Customer Request" ? "Customer" : _data[index].requestType ?? '',
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
                                                _data[index].status == "Ongoing" ? "In Progress" : _data[index].status ?? '',
                                                style: TextStyle(
                                                  color: _data[index].status == "Ongoing"
                                                      ? AppColors.inProgressStatusColor
                                                      : _data[index].status == "Pending"
                                                          ? AppColors.pendingStatusColor
                                                          : _data[index].status == "Accepted"
                                                              ? AppColors.greenTextColor
                                                              : _data[index].status == "Re-open"
                                                                  ? AppColors.reOpenStatusColor
                                                                  : _data[index].status == "Completed"
                                                                      ? AppColors.greenTextColor
                                                                      : _data[index].status == "Request for closure"
                                                                          ? AppColors.issueButtonColor
                                                                          : _data[index].status == "Rejected"
                                                                              ? AppColors.redText
                                                                              : AppColors.black,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 5.h,
                                                ),
                                                child: Text(
                                                  _data[index].facilityName ?? '',
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                                                  child: const Icon(
                                                    Icons.access_time_filled,
                                                    size: 20,
                                                    color: AppColors.ListTitleColor,
                                                  ),
                                                ),
                                                Text(
                                                  _data[index].estimatedTime.toString(),
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
                                            "Description: ${_data[index].description}",
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
                                            "Location: ${_data[index].location}",
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
                                            "Booths :${_data[index].booths.toString()}",
                                            style: TextStyle(
                                              color: AppColors.ListTitleColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.h,
                                              ),
                                              child: Text(
                                                "Total task : ${_data[index].totalTasks.toString()}",
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
                                                "Pending task : ${_data[index].pendingTasks.toString()}",
                                                style: TextStyle(
                                                  color: AppColors.redTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (_data[index].status == "Ongoing") ...[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Container(),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => const TaskCompletionScreen(),
                                                  //   ),
                                                  // );
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => TaskCompletionScreen(
                                                        allocationId: _data[index].taskAllocationId!,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.buttonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 40.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Close",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (_data[index].status == "Pending") ...[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {});

                                                  _dashboardBloc.add(UpdateStatus(id: _data[index].taskAllocationId!, status: 7));

                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => SelfieScreen(
                                                  //       isFromChooseFacility: true,
                                                  //       isFromTask: false,
                                                  //       templateId: _data[index].templateId!,
                                                  //       allocationId: _data[index].taskAllocationId!,
                                                  //     ),
                                                  //   ),
                                                  // );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.rejectButtonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Reject",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.rejectGreyTextColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  // Navigator.of(context).push(
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) => const JanitorList(),
                                                  //   ),
                                                  // );
                                                  _dashboardBloc.add(UpdateStatus(id: _data[index].taskAllocationId!, status: 2));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.acceptButtonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Accept",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                        if (_data[index].status == "Accepted") ...[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _url = Uri.parse('https://www.google.com/maps/dir/${widget.current_lattitude},${widget.current_longitude}/${_data[index].lat},${_data[index].lng}');
                                                  _launchUrl();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.buttonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Direction",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => SelfieScreen(
                                                        templateId: _data[index].templateId!,
                                                        allocationId: _data[index].taskAllocationId!,
                                                      ),
                                                    ),
                                                  );
                                                  print("afasdfasfsadf" + _data[index].taskAllocationId.toString());
                                                  _dashboardBloc.add(GetTaskTamplates(janitorId: janitorId));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.acceptButtonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Start",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                        if (_data[index].status == "Re-open") ...[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _url = Uri.parse('https://www.google.com/maps/dir/${widget.current_lattitude},${widget.current_longitude}/${_data[index].lat},${_data[index].lng}');
                                                  _launchUrl();
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.centerRight,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.buttonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Direction",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                      builder: (context) => SelfieScreen(
                                                        templateId: _data[index].templateId!,
                                                        allocationId: _data[index].taskAllocationId!,
                                                      ),
                                                    ),
                                                  );
                                                  print("afasdfasfsadf" + _data[index].taskAllocationId.toString());
                                                  _dashboardBloc.add(GetTaskTamplates(janitorId: janitorId));
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.r),
                                                      color: AppColors.acceptButtonColor,
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: 15.w,
                                                        vertical: 6.h,
                                                      ),
                                                      child: Text(
                                                        "Start",
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 10.sp,
                                                          fontWeight: FontWeight.w600,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ));
              });
        });
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
