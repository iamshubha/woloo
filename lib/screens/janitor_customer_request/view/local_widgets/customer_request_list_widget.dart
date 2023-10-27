import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/report_issue_screen/model/ItemModel.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';

// ignore: constant_identifier_names
// enum Status {ACTIVE, ENGAGED}

class RequestListWidget extends StatefulWidget {
  final String? requestType;
  final String? customerName;
  final String? dateAndTime;
  final String? location;
  final String? status;

  final Function onTapItem;
  const RequestListWidget({
    Key? key,
    required this.requestType,
    required this.customerName,
    required this.dateAndTime,
    required this.location,
    required this.onTapItem,
    required this.status,
  }) : super(key: key);

  @override
  State<RequestListWidget> createState() => _RequestListWidgetState();
}

class _RequestListWidgetState extends State<RequestListWidget> {
  int selectedCard = -1;

  final List<ItemModel> filter = [
    ItemModel(
      value: 0,
      label: "All",
    ),
    ItemModel(
      value: 1,
      label: "Pending",
    ),
    ItemModel(
      value: 2,
      label: "Accepted",
    ),
    ItemModel(
      value: 3,
      label: "On Going",
    ),
    ItemModel(
      value: 4,
      label: "Completed",
    ),
  ];
  var items = [
    'All',
    'Pending',
    'Accepted',
    'On Going',
    'Completed',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 15.h,
          ),
          child: GestureDetector(
            onTap: () {
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              //   child: DropDownDialog(
              //     // key: Key('${_editMarketModel.city?.label}T4'),
              //     // selected: cities.firstWhereOrNull((element) => element.value == _editMarketModel.city?.value),
              //     // widgetKey: _keys[2],
              //     items: filter,
              //     itemAsString: (ItemModel item) => item.label,
              //   ),
              // );
            },
            child: Container(
              width: 150.w,
              decoration: BoxDecoration(
                  color: AppColors.filterContainer,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.filterBorder)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      AppImages.filter_img,
                      height: 18.h,
                      width: 18.w,
                    ),
                    Text(
                      MyCustomerRequestListScreenConstants.FITER,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
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
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => const TaskList(),
                      //   ),
                      // );
                    },
                    child: Container(
                      height: 160.h,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                        widget.requestType ?? '',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          color: AppColors.clusterTitleColor,
                                          fontSize: 16.sp,
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
                                        widget.status ?? '',
                                        style: TextStyle(
                                          color: AppColors.pendingStatusColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
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
                                    MyCustomerRequestListScreenConstants
                                            .CUSTOMER_NAME +
                                        widget.customerName!,
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
                                    widget.dateAndTime!,
                                    style: TextStyle(
                                      color: AppColors.clusterTitleColor,
                                      fontSize: 10.sp,
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
                                    widget.location!,
                                    style: TextStyle(
                                      color: AppColors.clusterTitleColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                if (widget.status == "Pending") ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          // Navigator.of(context).push(
                                          //   MaterialPageRoute(
                                          //     builder: (context) => const JanitorList(),
                                          //   ),
                                          // );
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color:
                                                  AppColors.rejectButtonColor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 3.h,
                                              ),
                                              child: Text(
                                                MyCustomerRequestListScreenConstants
                                                    .REJECT_BUTTON,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors
                                                      .rejectGreyTextColor,
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 5.h),
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color:
                                                  AppColors.acceptButtonColor,
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 3.h,
                                              ),
                                              child: Text(
                                                MyCustomerRequestListScreenConstants
                                                    .ACCEPT_BUTTON,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                                if (widget.status == "Accepted") ...[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
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
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: AppColors.buttonColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 3.h,
                                            ),
                                            child: Text(
                                              MyCustomerRequestListScreenConstants
                                                  .DIRECTION_BUTTON,
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
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            color: AppColors.buttonColor,
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 8.w,
                                              vertical: 3.h,
                                            ),
                                            child: Text(
                                              MyCustomerRequestListScreenConstants
                                                  .START_BUTTON,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                                if (widget.status == "On-Going") ...[
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
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color: AppColors.buttonColor,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 3.h,
                                        ),
                                        child: Text(
                                          MyCustomerRequestListScreenConstants
                                              .CLOSURE_BUTTON,
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
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
