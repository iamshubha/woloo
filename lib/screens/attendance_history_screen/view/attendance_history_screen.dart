import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/bloc/history_list_state.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Attendance_history_model.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/data/model/Month_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/attendance_history_screen/view/local_widgets/history_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/empty_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/error_widget.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  const AttendanceHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceHistoryScreen> createState() =>
      AttendanceHistoryScreenState();
}

class AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  var monthItems = [
    MyAttendanceHistoryScreenConstants.JAN.tr(),
    MyAttendanceHistoryScreenConstants.FEB.tr(),
    MyAttendanceHistoryScreenConstants.MAR.tr(),
    MyAttendanceHistoryScreenConstants.APR.tr(),
    MyAttendanceHistoryScreenConstants.MAY.tr(),
    MyAttendanceHistoryScreenConstants.JUN.tr(),
    MyAttendanceHistoryScreenConstants.JUL.tr(),
    MyAttendanceHistoryScreenConstants.AUG.tr(),
    MyAttendanceHistoryScreenConstants.SEP.tr(),
    MyAttendanceHistoryScreenConstants.OCT.tr(),
    MyAttendanceHistoryScreenConstants.NOV.tr(),
    MyAttendanceHistoryScreenConstants.DEC.tr()
  ];
  List<MonthListModel> _data = [];
  List<AttendanceHistoryModel> _historyData = [];

  String dropdownvalue = MyAttendanceHistoryScreenConstants.SELECT.tr();
  HistoryListBloc _historyListBloc = HistoryListBloc();
  bool showList = false;

  @override
  void initState() {
    // TODO: implement initState
    _historyListBloc.add(const GetAllMonths());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30,
            ),
            color: AppColors.appBarIconColor,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
              vertical: 10.h,
            ),
            child: Text(
              MyJanitorProfileScreenConstants.ATTENDANCE_HISTORY.tr(),
              textAlign: TextAlign.start,
              style: TextStyle(
                color: AppColors.appBarTitleColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: AppColors.white,
          elevation: 0,
        ),
        body: BlocConsumer(
            bloc: _historyListBloc,
            listener: (context, state) {
              if (state is MonthListSuccess) {
                EasyLoading.dismiss();

                setState(() {
                  _data = state.data;
                });
              }
              if (state is HistoryListSuccess) {
                EasyLoading.dismiss();

                setState(() {
                  _historyData = state.data;
                  showList = true;
                });
              }
            },
            builder: (context, state) {
              if (state is MonthListLoading) {
                EasyLoading.show(
                    status: MydashboardScreenConstants.LOADING_TOAST.tr());
              }

              if (state is MonthListError) {
                EasyLoading.dismiss();
                return CustomErrorWidget(error: state.error);
              }

              if (state is MonthListSuccess && (state.data.isEmpty)) {
                EasyLoading.dismiss();
                return const EmptyListWidget();
              }
              if (state is HistoryListLoading) {
                EasyLoading.show(
                    status: MydashboardScreenConstants.LOADING_TOAST.tr());
              }

              if (state is HistoryListError) {
                EasyLoading.dismiss();
                return CustomErrorWidget(error: state.error);
              }

              if (state is HistoryListSuccess && (state.data.isEmpty)) {
                EasyLoading.dismiss();
                return const EmptyListWidget();
              }
              return SingleChildScrollView(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 10.h,
                          ),
                          child: SizedBox(
                            width: 140.w,
                            height: 50.h,
                            child: DropdownButtonFormField(
                              // Initial Value
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                ),
                                hintStyle: TextStyle(color: Colors.grey[800]),
                                hintText: MyAttendanceHistoryScreenConstants
                                    .SELECT
                                    .tr(),
                              ),

                              // Down Arrow Icon
                              icon: const Icon(Icons.arrow_drop_down_outlined),

                              // Array list of items
                              items: _data.map((MonthListModel items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(
                                    "${monthItems[(int.tryParse(items.month.toString()) ?? 1) - 1]} ${items.year}",
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkGreyText),
                                  ),
                                );
                              }).toList(),
                              // onChanged: (String? value) {  },
                              // After selecting the desired option,it will
                              // change button value to selected value
                              onChanged: (item) {
                                var i = item as MonthListModel;
                                _historyListBloc.add(GetAllHistory(
                                    month: i.month ?? '', year: i.year ?? ''));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  !showList
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 100.h,
                                ),
                                Image.asset(
                                  AppImages.blank_list_img,
                                  height: 100.h,
                                  width: 100.w,
                                ),
                                Text(
                                  MyAttendanceHistoryScreenConstants
                                      .BLANK_LIST_TEXT
                                      .tr(),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : HistoryListWidget(
                          onTapItem: () {},
                          data: _historyData,
                        ),
                ],
              ));
            }));
  }
}
