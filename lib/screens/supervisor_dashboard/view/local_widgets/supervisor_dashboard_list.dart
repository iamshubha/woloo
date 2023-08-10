import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/supervisor_dashboard/model/supervisor_dashboard_model.dart';
import 'package:janitor/utils/app_color.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class SupervisorDashboardListWidget extends StatefulWidget {
  // final String? name;
  // final String? description;
  // final String? location;
  // final String? booths;
  // final String? time;
  // final String status;
  // final String? total_tasks;
  // final String? pending_tasks;
  // final String? type;
  // final String? time_slot;
  final Function onTapItem;

  const SupervisorDashboardListWidget({
    Key? key,
    // required this.name,
    // required this.description,
    // required this.location,
    // required this.booths,
    // required this.time,
    // required this.status,
    // required this.total_tasks,
    // required this.pending_tasks,
    // required this.type,
    // required this.time_slot,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<SupervisorDashboardListWidget> createState() => _SupervisorDashboardListWidgetState();
}

class _SupervisorDashboardListWidgetState extends State<SupervisorDashboardListWidget> {
  int selectedCard = -1;

  bool isSelected = false;
  final List<SupervisorDashboardModel> _list = [
    SupervisorDashboardModel(
      id: 0,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: Rest room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: 'IOT',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Uma Jadhav',
    ),
    SupervisorDashboardModel(
      id: 1,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: 'Regular',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Ajay Deshmukh',
    ),
    SupervisorDashboardModel(
      id: 2,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: 'Issue',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Prashant Wankhade',
    ),
    SupervisorDashboardModel(
      id: 3,
      name: "Floor 2, Ladies Rest Room, CMF",
      description: 'Description: PWD Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: "Customer",
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Uma Jadhav',
    ),
    SupervisorDashboardModel(
      id: 4,
      name: "Gents Rest Room",
      description: 'Description: Gents Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: 'Customer',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Ajay Deshmukh',
    ),
    SupervisorDashboardModel(
      id: 5,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 2',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Request for closure",
      type: 'Issue',
      timeSlot: '9:30 AM-11:30 AM',
      date: '08 July 2023 ',
      janitorName: 'Prashant Wankhade',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _list.length,
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
                child: _list[index].status == "Completed"
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
                                          _list[index].date ?? '',
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
                                          _list[index].timeSlot ?? '',
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
                                              _list[index].type ?? '',
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
                                          _list[index].status ?? '',
                                          style: TextStyle(
                                            color: _list[index].status == "In Progress"
                                                ? AppColors.inProgressStatusColor
                                                : _list[index].status == "Pending"
                                                    ? AppColors.pendingStatusColor
                                                    : _list[index].status == "Accepted"
                                                        ? AppColors.greenTextColor
                                                        : _list[index].status == "Re-open"
                                                            ? AppColors.reOpenStatusColor
                                                            : _list[index].status == "Completed"
                                                                ? AppColors.greenTextColor
                                                                : _list[index].status == "Request for closure"
                                                                    ? AppColors.yellowTextColor
                                                                    : AppColors.black,
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
                                      // Expanded(
                                      //   child: Container(),
                                      // ),

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
                                          _list[index].date ?? '',
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
                                          _list[index].timeSlot ?? '',
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
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                          vertical: 5.h,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: _list[index].type == "IOT"
                                                  ? AppColors.iotBackgroundColor
                                                  : _list[index].type == "Regular"
                                                      ? AppColors.regularButtonColor
                                                      : _list[index].type == "Issue"
                                                          ? AppColors.issueButtonColor
                                                          : _list[index].type == "Customer"
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
                                              _list[index].type ?? '',
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
                                          _list[index].status ?? '',
                                          style: TextStyle(
                                            color: _list[index].status == "In Progress"
                                                ? AppColors.inProgressStatusColor
                                                : _list[index].status == "Pending"
                                                    ? AppColors.pendingStatusColor
                                                    : _list[index].status == "Accepted"
                                                        ? AppColors.greenTextColor
                                                        : _list[index].status == "Re-open"
                                                            ? AppColors.reOpenStatusColor
                                                            : _list[index].status == "Completed"
                                                                ? AppColors.greenTextColor
                                                                : Colors.black,
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
                                            _list[index].name ?? '',
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
                                            _list[index].time ?? '',
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
                                      _list[index].description ?? '',
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
                                      _list[index].location ?? '',
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
                                      _list[index].booths ?? '',
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
                                          _list[index].total_task ?? '',
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
                                          _list[index].pending_task ?? '',
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Icon(Icons.person, color: AppColors.black, size: 15.sp, weight: 0.5),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 2.h,
                                            ),
                                            child: Text(
                                              _list[index].janitorName ?? '',
                                              style: TextStyle(
                                                color: AppColors.janitorNameColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => const TaskCompletionScreen(),
                                          //   ),
                                          // );
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
                                                "Approve",
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
                                      )
                                    ],
                                  ),
                                  // if (_list[index].status == "Pending") ...[
                                  //   Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                  //     children: [
                                  //       InkWell(
                                  //         onTap: () {
                                  //           setState(() {});
                                  //           Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //               builder: (context) => const SelfieScreen(
                                  //                 isFromChooseFacility: true,
                                  //                 isFromTask: false,
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                  //           child: Container(
                                  //             alignment: Alignment.centerRight,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(8.r),
                                  //               color: AppColors.rejectButtonColor,
                                  //             ),
                                  //             child: Padding(
                                  //               padding: EdgeInsets.symmetric(
                                  //                 horizontal: 15.w,
                                  //                 vertical: 6.h,
                                  //               ),
                                  //               child: Text(
                                  //                 "Reject",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                   fontSize: 10.sp,
                                  //                   fontWeight: FontWeight.w600,
                                  //                   color: AppColors.rejectGreyTextColor,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {
                                  //           // Navigator.of(context).push(
                                  //           //   MaterialPageRoute(
                                  //           //     builder: (context) => const JanitorList(),
                                  //           //   ),
                                  //           // );
                                  //         },
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                  //           child: Container(
                                  //             alignment: Alignment.center,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(8.r),
                                  //               color: AppColors.acceptButtonColor,
                                  //             ),
                                  //             child: Padding(
                                  //               padding: EdgeInsets.symmetric(
                                  //                 horizontal: 15.w,
                                  //                 vertical: 6.h,
                                  //               ),
                                  //               child: Text(
                                  //                 "Accept",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                   fontSize: 10.sp,
                                  //                   fontWeight: FontWeight.w600,
                                  //                   color: AppColors.white,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ],
                                  // if (_list[index].status == "Accepted") ...[
                                  //   Row(
                                  //     mainAxisAlignment: MainAxisAlignment.end,
                                  //     crossAxisAlignment: CrossAxisAlignment.end,
                                  //     children: [
                                  //       InkWell(
                                  //         onTap: () {
                                  //           Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //               builder: (context) => const SelfieScreen(
                                  //                 isFromChooseFacility: true,
                                  //                 isFromTask: false,
                                  //               ),
                                  //             ),
                                  //           );
                                  //         },
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                  //           child: Container(
                                  //             alignment: Alignment.centerRight,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(8.r),
                                  //               color: AppColors.buttonColor,
                                  //             ),
                                  //             child: Padding(
                                  //               padding: EdgeInsets.symmetric(
                                  //                 horizontal: 15.w,
                                  //                 vertical: 6.h,
                                  //               ),
                                  //               child: Text(
                                  //                 "Direction",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                   fontSize: 10.sp,
                                  //                   fontWeight: FontWeight.w600,
                                  //                   color: AppColors.black,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //       InkWell(
                                  //         onTap: () {
                                  //           Navigator.of(context).push(
                                  //             MaterialPageRoute(
                                  //               builder: (context) => const SelfieScreen(),
                                  //             ),
                                  //           );
                                  //         },
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                  //           child: Container(
                                  //             alignment: Alignment.center,
                                  //             decoration: BoxDecoration(
                                  //               borderRadius: BorderRadius.circular(8.r),
                                  //               color: AppColors.acceptButtonColor,
                                  //             ),
                                  //             child: Padding(
                                  //               padding: EdgeInsets.symmetric(
                                  //                 horizontal: 15.w,
                                  //                 vertical: 6.h,
                                  //               ),
                                  //               child: Text(
                                  //                 "Start",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                   fontSize: 10.sp,
                                  //                   fontWeight: FontWeight.w600,
                                  //                   color: AppColors.white,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ));
        });
  }
}
