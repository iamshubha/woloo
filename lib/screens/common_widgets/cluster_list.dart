import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/utils/app_constants.dart';

import '../../utils/app_color.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class ClusterListWidget extends StatefulWidget {
  final String? title;
  final String? pincode;
  final String? janitorName;
  final String? total_tasks;
  final String? pending_tasks;
  final Function onTapItem;
  const ClusterListWidget({
    Key? key,
    required this.title,
    required this.pincode,
    required this.janitorName,
    required this.total_tasks,
    required this.pending_tasks,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<ClusterListWidget> createState() => _ClusterListWidgetState();
}

class _ClusterListWidgetState extends State<ClusterListWidget> {
  int selectedCard = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
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
                height: 150.h,
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                  horizontal: 10.w,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 20.w,
                ),
                decoration: BoxDecoration(
                  color: selectedCard == index ? AppColors.containerColor : AppColors.white,
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
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                              vertical: 2.h,
                            ),
                            child: Text(
                              widget.title ?? '',
                              style: TextStyle(
                                color: AppColors.clusterTitleColor,
                                fontSize: 18.sp,
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
                              "Pin Code : " + widget.pincode!,
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
                              "Janitor name-" + widget.janitorName!,
                              style: TextStyle(
                                color: AppColors.clusterTitleColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  "Total task :" + widget.total_tasks!,
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
                                  "Pending task :" + widget.pending_tasks!,
                                  style: TextStyle(
                                    color: AppColors.redTextColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
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
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    color: AppColors.buttonColor,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      MyClusterListScreenConstants.BTN_TEXT,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
