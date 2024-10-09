import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Attendance_history_model.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryListWidget extends StatefulWidget {
  final List<AttendanceHistoryModel> data;

  final Function onTapItem;
  const HistoryListWidget({
    Key? key,
    required this.data,
    required this.onTapItem,
  }) : super(key: key);

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  int selectedCard = -1;
  HistoryListBloc _historyListBloc = HistoryListBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          Duration(seconds: 1),
          () {
            _historyListBloc.add(GetAllHistory(month: '10', year: '2023'));
          },
        );
      },
      color: AppColors.buttonColor,
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: widget.data.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
              ),
              child: GestureDetector(
                onTap: () {
                  widget.onTapItem(widget.data[index]);
               
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
                        ? AppColors.red
                        : AppColors.containerShadow,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.containerBorder,
                      width: 1.w,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 5.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 60.h,
                          width: 56.w,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 11.0,
                                  spreadRadius: 0,
                                  offset: Offset(1, 1),
                                  color: AppColors.greyShadow,
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: Column(
                            children: [
                              Text(
                                widget.data[index].date ?? '',
                                style: 
                               AppTextStyle.font18.copyWith(
                                color: AppColors.historyText,
                              )     
                              ),
                              Text(
                                widget.data[index].dayOfWeek ?? '',
                                style:
                                 AppTextStyle.font18.copyWith(
                                color: AppColors.historyText,
                              )  
                            
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                              Container(
                              width: 90.w,
                              child: Text(
                                  textAlign: TextAlign.center,
                                maxLines: 2,
                               overflow: TextOverflow.clip,
                                MydashboardScreenConstants.CHECK_IN.tr(),
                                style:
                                 AppTextStyle.font16.copyWith(
                                  color: AppColors.historyText,
                                                         )
                              ),
                            ),
                            Text(
                              " ${widget.data[index].checkIn ?? '-'}",
                              style:
                              AppTextStyle.font13.copyWith(
                                 color: AppColors.lightGreyText,
                              )  
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 90.w,
                              child: Center(
                                child: Text(
                                   textAlign: TextAlign.center,
                                   maxLines: 2,                        //     overflow: TextOverflow.fade,
                                  MydashboardScreenConstants.CHECK_OUT.tr(),
                                  style:
                                  AppTextStyle.font16.copyWith(
                                    color: AppColors.historyText,
                                  )
                                ),
                              ),
                            ),
                            Text(
                              widget.data[index].checkOut ?? '-',
                              style:
                              AppTextStyle.font13.copyWith(
                                color: AppColors.lightGreyText,
                              )
                            )
                          ],
                        ),
                        Center(
                          child: Text(
                            widget.data[index].attendance ?? '',
                            style: 
                              AppTextStyle.font13w7.copyWith(
                                  color: 
                                  widget.data[index].attendance == "Present"
                                  ? AppColors.greenBold
                                  : AppColors.redBold,
                                )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
