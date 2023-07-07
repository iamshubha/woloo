import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:janitor/utils/app_images.dart';

import '../../utils/app_color.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class IssueListWidget extends StatefulWidget {
  final String? name;
  final String? facilityName;
  final String? janitorName;
  final String? status;
  final Function onTapItem;

  const IssueListWidget({
    Key? key,
    required this.name,
    required this.facilityName,
    required this.janitorName,
    required this.status,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<IssueListWidget> createState() => _IssueListWidgetState();
}

class _IssueListWidgetState extends State<IssueListWidget> {
  bool pending = false;
  int selectedCard = -1;

  @override
  void initState() {
    pending = true;
    super.initState();
  }

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
                        // mainAxisAlignment: MainAxisAlignment.start,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                            child: Container(
                              height: 62.h,
                              width: 62.w,
                              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.darkGreyColor),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                                child: Image.asset(
                                  AppImages.bed_img,
                                  height: 39.h,
                                  width: 39.w,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 2.h,
                                ),
                                child: Text(
                                  widget.name!,
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
                                  widget.facilityName!,
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
                                  widget.janitorName!,
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
                                  widget.status!,
                                  style: TextStyle(
                                    color: pending ? AppColors.redText : AppColors.greenText,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
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
