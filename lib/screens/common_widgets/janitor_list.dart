import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_color.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class JanitorListWidget extends StatefulWidget {
  final String? janitorName;
  final String? mobile;
  final String? cluster;
  final String? pincode;
  final Function onTapItem;

  const JanitorListWidget({
    Key? key,
    required this.janitorName,
    required this.pincode,
    required this.cluster,
    required this.mobile,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<JanitorListWidget> createState() => _JanitorListWidgetState();
}

class _JanitorListWidgetState extends State<JanitorListWidget> {
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
            padding: EdgeInsets.symmetric(vertical: 7.h),
            child: GestureDetector(
              onTap: () {
                widget.onTapItem();
                setState(() {
                  selectedCard = index;
                });
              },
              child: Container(
                height: 140.h,
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
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                            child: Container(
                              height: 40.h,
                              width: 40.w,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreyColor),
                              child: const Icon(
                                Icons.person_2_outlined,
                                color: AppColors.buttonColor,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  widget.janitorName ?? '',
                                  style: TextStyle(
                                    color: AppColors.janitorNameColor,
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
                                  "Mob.no." + widget.mobile!,
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
                                  widget.cluster ?? '',
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
                                  "Pin code : " + widget.pincode!,
                                  style: TextStyle(
                                    color: AppColors.clusterTitleColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
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
        });
  }
}
