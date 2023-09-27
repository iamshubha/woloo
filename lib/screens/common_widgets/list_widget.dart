import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:janitor/core/local/global_storage.dart';
import 'package:janitor/screens/choose_facility_screen/bloc/facility_list_bloc.dart';
import 'package:janitor/screens/choose_facility_screen/bloc/facility_list_event.dart';
import 'package:janitor/screens/choose_facility_screen/bloc/facility_list_state.dart';
import 'package:janitor/screens/choose_facility_screen/data/model/Facility_list_model.dart';

import '../../utils/app_color.dart';
import 'empty_list_widget.dart';
import 'error_widget.dart';

class ListWidget extends StatefulWidget {
  final TextEditingController controller;
  final String janitorId;
  final Function onTapItem;
  final bool isCheckedSelectAll;
  final Function onChecked;
  final Function onSetData;
  List<bool> checkList;

  ListWidget({
    Key? key,
    required this.controller,
    required this.onTapItem,
    required this.janitorId,
    this.isCheckedSelectAll = false,
    required this.onChecked,
    required this.onSetData,
    required this.checkList,
  }) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  int selectedCard = -1;
  late int janitorId;
  List<FacilityListModel> _data = [];
  List<FacilityListModel> _search = [];
  GlobalStorage globalStorage = GetIt.instance();
  FacilityListBloc _facilityListBloc = FacilityListBloc();
  bool isSelected = false;
  var _task;
  @override
  void initState() {
    _facilityListBloc.add(GetAllFacility(janitorId: widget.janitorId ?? ''));
    widget.controller.addListener(() {
      setState(() {
        if (widget.controller.text.isEmpty) {
          _search = _data;
          return;
        }

        _search = _data
            .where((element) =>
                element.facilityName
                    ?.toLowerCase()
                    .contains(widget.controller.text.toLowerCase()) ??
                false)
            .toList();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _facilityListBloc,
        listener: (context, state) {
          if (state is FacilityListSuccess) {
            EasyLoading.dismiss();

            setState(() {
              _data = state.data;
              _search = _data;
              widget.onSetData(_data);
              widget.onSetData(_search);
            });
          }
        },
        builder: (context, state) {
          if (state is FacilityListLoading && _search.isEmpty) {
            EasyLoading.show(status: "Loading Please Wait ...");
          }

          if (state is FacilityListError) {
            EasyLoading.dismiss();
            return CustomErrorWidget(error: state.error);
          }

          if (state is FacilityListSuccess && (state.data.isEmpty)) {
            EasyLoading.dismiss();
            return const EmptyListWidget();
          }

          return RefreshIndicator(
            onRefresh: () {
              return Future.delayed(
                Duration(seconds: 1),
                () {
                  _facilityListBloc
                      .add(GetAllFacility(janitorId: widget.janitorId ?? ''));
                },
              );
            },
            color: AppColors.buttonColor,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _search.length,
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
                            try {
                              // widget.onTapItem(_search[index], check);
                              // setState(() {
                              //   selectedCard = index;
                              //   check = !check;
                              // });
                              setState(() {
                                widget.checkList[index] =
                                    !widget.checkList[index];
                                widget.onChecked(widget.checkList[index],
                                    _search[index], _data);
                              });
                            } catch (e) {
                              print("onTapppppp" + e.toString());
                            }
                          },
                          child: Container(
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
                                color: widget.checkList[index]
                                    ? AppColors.buttonColor
                                    : AppColors.containerBorder,
                                width: widget.checkList[index] ? 2.w : 1.w,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 5.w,
                                              vertical: 5.h,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: _search[index]
                                                            .requestType ==
                                                        "IOT"
                                                    ? AppColors
                                                        .iotBackgroundColor
                                                    : _search[index]
                                                                .requestType ==
                                                            "Regular"
                                                        ? AppColors
                                                            .regularButtonColor
                                                        : _search[index]
                                                                    .requestType ==
                                                                "Issue"
                                                            ? AppColors
                                                                .issueButtonColor
                                                            : _search[index]
                                                                        .requestType ==
                                                                    "Customer Request"
                                                                ? AppColors
                                                                    .acceptButtonColor
                                                                : AppColors
                                                                    .white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  10.r,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 5.h,
                                                  horizontal: 20.w,
                                                ),
                                                child: Text(
                                                  _search[index].requestType ??
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
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
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
                                                  "${_search[index].startTime} - ${_search[index].endTime}" ??
                                                      '',
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.timeSlotColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                                looping(_search[index]),
                                                maxLines: 1,
                                                // softWrap: false,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color:
                                                      AppColors.ListTitleColor,
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
                                                      AppColors.ListTitleColor,
                                                ),
                                              ),
                                              Text(
                                                "${_search[index].estimatedTime.toString()} min" ??
                                                    '',
                                                style: TextStyle(
                                                  color:
                                                      AppColors.ListTitleColor,
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
                                          "${_search[index].facilityName}" ??
                                              '',
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
                                          "Description: ${_search[index].description}" ??
                                              '',
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
                                          "Location: ${_search[index].locationName}" ??
                                              '',
                                          style: TextStyle(
                                            color: AppColors.ListTitleColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
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
                                                  _search[index].janitorName ??
                                                      '',
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
                                          widget.checkList[index]
                                              ? Icon(Icons.check_circle,
                                                  color: AppColors
                                                      .acceptButtonColor,
                                                  size: 20.sp,
                                                  weight: 0.5)
                                              : Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )));
                }),
          );
        });
  }

  String looping(FacilityListModel taskObject) {
    String tastName = '';
    print("task------->  ${taskObject.toJson()}");
    if (taskObject.taskStatus != null) {
      for (var i = 0; i < taskObject.taskStatus!.length; i++) {
        tastName += taskObject.taskStatus![i].taskName!;
      }
    }

    return tastName;
  }
}
