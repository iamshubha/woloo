import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/screens/choose_facility_screen/model/facility_data.dart';
import 'package:janitor/screens/selfie_screen/view/selfie_screen.dart';

import '../../utils/app_color.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class ListWidget extends StatefulWidget {
  // final String? name;
  // final String? description;
  // final String? location;
  // final String? booths;
  // final String? time;
  // final String status;
  // final String? total_tasks;
  // final String? pending_tasks;
  final Function onTapItem;

  const ListWidget({
    Key? key,
    // required this.name,
    // required this.description,
    // required this.location,
    // required this.booths,
    // required this.time,
    // required this.status,
    // required this.total_tasks,
    // required this.pending_tasks,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  int selectedCard = -1;

  bool isSelected = false;
  final List<FacilityModel> _list = [
    FacilityModel(
      id: 0,
      name: "Restroom",
      description: 'Description: Rest room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "In Progress",
    ),
    FacilityModel(
      id: 1,
      name: "Gents Restroom",
      description: 'Description: Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Pending",
    ),
    FacilityModel(
      id: 2,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "In Progress",
    ),
    FacilityModel(
      id: 3,
      name: "PWD Restroom",
      description: 'Description: PWD Restroom',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 1',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Pending",
    ),
    FacilityModel(
      id: 4,
      name: "Gents Rest Room",
      description: 'Description: Gents Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 3',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "In Progress",
    ),
    FacilityModel(
      id: 5,
      name: "Ladies Rest Room",
      description: 'Description: Ladies Rest Room',
      location: 'Location: Wipro, Hinjewadi Phase-2',
      booths: 'Booths : 2',
      total_task: 'Total task : 2',
      pending_task: 'Pending task : 2',
      time: '30 min',
      status: "Pending",
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
                child: Container(
                  height: 170.h,
                  padding: EdgeInsets.symmetric(
                    vertical: 5.h,
                    horizontal: 10.w,
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: 20.w,
                  ),
                  decoration: BoxDecoration(
                    color: _list[index].status == "In Progress" ? AppColors.greenCardColor : AppColors.yellowCardColor,
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                    vertical: 1.h,
                                  ),
                                  child: Text(
                                    _list[index].name ?? '',
                                    style: TextStyle(
                                      color: AppColors.ListTitleColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w600,
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
                                    _list[index].status ?? '',
                                    style: TextStyle(
                                      color: AppColors.greenTextColor,
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
                                    vertical: 1.h,
                                  ),
                                  child: Text(
                                    _list[index].description ?? '',
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
                                    vertical: 1.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5.w,
                                        ),
                                        child: const Icon(
                                          Icons.access_time_filled,
                                          size: 20,
                                          color: AppColors.black,
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
                                ),
                              ],
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
                                    _list[index].pending_task ?? '',
                                    style: TextStyle(
                                      color: AppColors.redTextColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (_list[index].status == "In Progress") ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {});
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const SelfieScreen(
                                            isFromChooseFacility: true,
                                            isFromTask: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                      child: Container(
                                        alignment: Alignment.centerRight,
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
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const JanitorList(),
                                      //   ),
                                      // );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                      child: Container(
                                        alignment: Alignment.center,
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
                                            "Close",
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
                                  )
                                ],
                              ),
                            ],
                            if (_list[index].status == "Pending") ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => const SelfieScreen(
                                            isFromChooseFacility: true,
                                            isFromTask: false,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                      child: Container(
                                        alignment: Alignment.centerRight,
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
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //     builder: (context) => const JanitorList(),
                                      //   ),
                                      // );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                      child: Container(
                                        alignment: Alignment.center,
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
                                            "Close",
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
  }
}
