import 'dart:async';

import 'package:Woloo_Smart_hygiene/core/local/global_storage.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/empty_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/error_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/map_utils.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_event.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/bloc/dashboard_state.dart';
import 'package:Woloo_Smart_hygiene/screens/dashboard/data/model/dashboard_model_class.dart';
import 'package:Woloo_Smart_hygiene/screens/selfie_screen/view/selfie_screen.dart';
import 'package:Woloo_Smart_hygiene/screens/washroom_image_screen/view/task_completion_screen.dart';
import 'package:Woloo_Smart_hygiene/utils/app_color.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
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
  List<DashboardModelClass> filter = [];
  List<DashboardModelClass> _data = [] ;
  late double? facility_lattitude;
  late double? facility_longitude;
  bool servicestatus = false;
  bool haspermission = false;
  late Uri _url;
  GlobalStorage globalStorage = GetIt.instance();
  bool isSelected = false;
  late int janitorId;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  String latitude = "";
  String longitude = "";

  String? _currentAddress;
  String dropdownvalue = 'All';

  // List of items in our dropdown menu
  var items = [
    'All',
    'Ongoing',
    'Pending',
    'Accepted',
    'Completed',
    'Request for closure'
  ];


  @override
  void initState() {
    _dashboardBloc = DashboardBloc();
    janitorId = globalStorage.getId();
    _dashboardBloc.add(GetTaskTamplates());

    latitude = globalStorage.getLatitude();
    longitude = globalStorage.getLongitude();
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
             filter =  _data  ;
          });
        }

        if (state is UpdateStatusSuccessful) {
          EasyLoading.dismiss();
          print("status updated");
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading && _data.isEmpty) {
          EasyLoading.show(status: MydashboardScreenConstants.LOADING_TOAST.tr());
        }

        if (state is DashboardError) {
          return CustomErrorWidget(error: state.error);
        }

        if (state is UpdateStatusError) {
          return CustomErrorWidget(error: state.error);
        }
        if (state is UpdateStatusLoading) {
          EasyLoading.show(status: MydashboardScreenConstants.LOADING_TOAST.tr());
        }

        if (state is GetDashboardDataSuccess && _data.isEmpty) {
          EasyLoading.dismiss();
          return EmptyListWidget();
        }

        return


           Container(
             height: MediaQuery.of(context).size.height/1.3,
             child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  toolbarHeight: 79,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: AppColors.white,
                   actions: [
                     Center(
                       child: Padding(
                         padding: EdgeInsets.symmetric(
                           horizontal: 25.h,
                            vertical: 10.h
                         ),
                         child: SizedBox(
                           width:  250,
                           height: 70,
                           child: DropdownButtonFormField(
                             decoration: const InputDecoration(

                               border: OutlineInputBorder(
                                 borderRadius: BorderRadius.all(
                                   Radius.circular(30.0),
                                 ),
                               ),),
                             elevation: 0,
                             // Initial Value
                             value: dropdownvalue,
                             // Down Arrow Icon
                             icon: const Icon(Icons.keyboard_arrow_down),

                             // Array list of items
                             items: items.map((String items) {
                               return DropdownMenuItem(

                                 value: items,
                                 child: Text(items),
                               );
                             }).toList(),
                             dropdownColor: Colors.white,

                             onChanged: (String? newValue) {
                               setState(() {
                                 dropdownvalue = newValue!;
                               });
                               print('new $newValue ');
                               if(newValue == "All"){
                                 filter = _data;
                               }else {
                                 filter =  _data.where( (e)=> e.status == newValue ).toList();
                               }


                               print(" filter data${filter}");
                             },
                           ),
                         ),
                       ),
                     ),
                   ],



                ),
              body: Padding(
                padding: const EdgeInsets.only( top: 10 , bottom: 20 ),
                child:

                filter.isEmpty ?

                EmptyListWidget()

                 :
                ListView.builder(
                  // physics: BouncingScrollPhysics(),
                  itemCount: filter.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 6.h,

                      ),
                      child: GestureDetector(
                        onTap: () {
                          widget.onTapItem();
                          setState(() {
                            selectedCard = index;
                          });
                        },
                        child: filter[index].status == "Completed"
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
                                  color:

                                  AppColors.disabledContainerColor,
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
                                                  filter[index].date ?? '',
                                                  overflow: TextOverflow.ellipsis,
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
                                                  "${filter[index].startTime}-${filter[index].endTime}",
                                                  overflow: TextOverflow.ellipsis,
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
                                                    color: getColorByRequestType(filter[index].requestType ?? ''),
                                                    borderRadius: BorderRadius.circular(10.r),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 20.w,
                                                    ),
                                                    child: Text(
                                                      (filter[index].requestType ?? '').tr(),
                                                      overflow: TextOverflow.ellipsis,
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
                                                  (filter[index].status ?? '').tr(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: getColorByStatus(filter[index].status ?? ''),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 0.h,
                                                ),
                                                child: Text(
                                                   'Task ID :'

                                                      ?? '',
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.containerBorder,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.w,
                                                   vertical: 0.h,
                                                ),
                                                child: Text(
                                                  filter[index].taskAllocationId

                                                      ?? '',
                                                  maxLines: 1,
                                                  softWrap: false,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.containerBorder,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: 0.8,
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
                                                child:
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 5.w,
                                                    vertical: 5.h,
                                                  ),
                                                  child: Text(
                                                    filter[index].facilityName

                                                        ?? '',
                                                    maxLines: 1,
                                                    softWrap: false,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColors.containerBorder,
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
                                                      color: AppColors.containerBorder,
                                                    ),
                                                  ),
                                                  Text(
                                                    filter[index].estimatedTime.toString(),
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: AppColors.containerBorder,
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
                                              "${MydashboardScreenConstants.DESCRIPTION.tr()}: ${filter[index].description}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
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
                                              "${MydashboardScreenConstants.LOCATION.tr()} : ${filter[index].location}",
                                              overflow: TextOverflow.ellipsis,
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
                                              "${MydashboardScreenConstants.BOOTHS.tr()} :${filter[index].booths?.toString() ?? ''}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.containerBorder,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          if ((filter[index].requestType == "Issue")) ...[
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                              child: Text(
                                                "${(filter[index].requestType ?? '').tr()} : ${filter[index].issueDescription ?? '-'}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.ListTitleColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                  "${MydashboardScreenConstants.TOTAL_TASK.tr()}: ${filter[index].totalTasks.toString() ?? ''}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.disabledGreenColor,
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
                                                  "${MydashboardScreenConstants.COMPLETE_TASK.tr()}: ${filter[index].pendingTasks.toString()}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.disabledRedColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
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
                                    color:

                                    filter[index].status == "Pending" ?

                                    AppColors.redTextColor :
                                    filter[index].status == "Ongoing" ?
                                    AppColors.buttonColor :
                                    filter[index].status == "Accepted" ?
                                    AppColors.acceptButtonColor :
                                    filter[index].status == "Request for closure" ?
                                    AppColors.issueButtonColor

                                      :   AppColors.disabledContainerBorder
                                    ,
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
                                                color: AppColors.timeSlotColor,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 1.h,
                                                ),
                                                child: Text(
                                                  filter[index].date ?? '',
                                                  overflow: TextOverflow.ellipsis,
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
                                                  "${filter[index].startTime}-${filter[index].endTime}",
                                                  overflow: TextOverflow.ellipsis,
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
                                                    color: getColorByRequestType(filter[index].requestType ?? ''),
                                                    borderRadius: BorderRadius.circular(10.r),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      vertical: 5.h,
                                                      horizontal: 20.w,
                                                    ),
                                                    child: Text(
                                                      (filter[index].requestType ?? '').tr(),
                                                      overflow: TextOverflow.ellipsis,
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
                                                  (filter[index].status ?? '').tr(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: getColorByStatus(filter[index].status ?? ''),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 5.w,
                                                  vertical: 0.h,
                                                ),
                                                child: Text(
                                                  'Task ID :'

                                                      ?? '',
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
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 0.w,
                                                  vertical: 0.h,
                                                ),
                                                child: Text(
                                                  filter[index].taskAllocationId

                                                      ?? '',
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
                                                    filter[index].facilityName ?? '',
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
                                                    filter[index].estimatedTime.toString(),
                                                    overflow: TextOverflow.ellipsis,
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
                                              "${MydashboardScreenConstants.DESCRIPTION.tr()}: ${filter[index].description ?? '-'}",
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
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
                                              "${MydashboardScreenConstants.LOCATION.tr()}: ${filter[index].location ?? '-'}",
                                              overflow: TextOverflow.ellipsis,
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
                                              "${MydashboardScreenConstants.BOOTHS.tr()} :${filter[index].booths?.toString() ?? ''}",
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: AppColors.ListTitleColor,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          if ((filter[index].requestType == "Issue")) ...[
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                                              child: Text(
                                                "${(filter[index].requestType ?? '').tr()} : ${filter[index].issueDescription ?? '-'}",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: AppColors.ListTitleColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
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
                                                  "${MydashboardScreenConstants.TOTAL_TASK.tr()}: ${filter[index].totalTasks?.toString() ?? '-'}",
                                                  overflow: TextOverflow.ellipsis,
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
                                                  "${MydashboardScreenConstants.PENDING_TASK.tr()}: ${filter[index].pendingTasks?.toString() ?? '-'}",
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    color: AppColors.redTextColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          if (filter[index].status == "Ongoing") ...[
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
                                                          allocationId: filter[index].taskAllocationId ?? '',
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
                                                          MydashboardScreenConstants.CLOSE.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                                          if (filter[index].status == "Pending") ...[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    setState(() {});

                                                    _dashboardBloc.add(UpdateStatus(id: filter[index].taskAllocationId!, status: "7"));

                                                    // Navigator.of(context).push(
                                                    //   MaterialPageRoute(
                                                    //     builder: (context) => SelfieScreen(
                                                    //       isFromChooseFacility: true,
                                                    //       isFromTask: false,
                                                    //       templateId: filter[index].templateId!,
                                                    //       allocationId: filter[index].taskAllocationId!,
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
                                                          MydashboardScreenConstants.REJECT.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                                                    _dashboardBloc.add(UpdateStatus(id: filter[index].taskAllocationId ?? '', status: "2"));
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
                                                          MydashboardScreenConstants.ACCEPT.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                                          if (filter[index].status == "Accepted") ...[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    checkGps();
                                                    setState(() {
                                                      facility_lattitude = filter[index].lat;
                                                      facility_longitude = filter[index].lng;
                                                    });
                                                    await MapUtils.openMap(filter[index].lat ?? 0.0, filter[index].lng ?? 0.0);
                                                    // _url = Uri.parse(
                                                    //     'https://www.google.com/maps/dir/${latitude},${longitude}/${filter[index].lat},${filter[index].lng}');
                                                    // await _launchUrl();
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
                                                          MydashboardScreenConstants.DIRECTION.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                                                          templateId: filter[index].templateId ?? 0,
                                                          allocationId: filter[index].taskAllocationId ?? '',
                                                        ),
                                                      ),
                                                    );
                                                    print("afasdfasfsadf" + filter[index].taskAllocationId.toString());
                                                    _dashboardBloc.add(GetTaskTamplates());
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
                                                          MydashboardScreenConstants.START.tr(),
                                                          overflow: TextOverflow.ellipsis,
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
                                          if (filter[index].status == "Re-open") ...[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    checkGps();
                                                    await MapUtils.openMap(filter[index].lat ?? 0.0, filter[index].lng ?? 0.0);
                                                    // _url = Uri.parse(
                                                    //     'https://www.google.com/maps/dir/${latitude},${longitude}/${filter[index].lat},${filter[index].lng}');
                                                    // await _launchUrl();
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
                                                          MydashboardScreenConstants.DIRECTION.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                                                          templateId: filter[index].templateId!,
                                                          allocationId: filter[index].taskAllocationId ?? '',
                                                        ),
                                                      ),
                                                    );
                                                    print("afasdfasfsadf" + filter[index].taskAllocationId.toString());
                                                    _dashboardBloc.add(const GetTaskTamplates());
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
                                                          MydashboardScreenConstants.START.tr(),
                                                          textAlign: TextAlign.center,
                                                          overflow: TextOverflow.ellipsis,
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
                      ),
                    );
                  },
                ),
              ),
                       ),
           );
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception("${MydashboardScreenConstants.URL_ERR_TOAST.tr()} $_url");
    }
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        await getLocation();
      }

      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      EasyLoading.showToast(MydashboardScreenConstants.GPS_DISABLED_TOAST.tr());
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      _getAddressFromLatLng(position);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude).then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = '${place.name},${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.administrativeArea},${place.postalCode}';
        print("address - $_currentAddress");
        // EasyLoading.showToast("Current Location Detected : $_currentAddress");
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Color getColorByRequestType(String requestType) {
    switch (requestType) {
      case "IOT":
        return AppColors.iotBackgroundColor;
      case "Regular":
        return AppColors.regularButtonColor;
      case "Issue":
        return AppColors.issueButtonColor;
      case "Customer Request":
        return AppColors.acceptButtonColor;
      default:
        return AppColors.white;
    }
  }

  Color getColorByStatus(String status) {
    switch (status) {
      case "Ongoing":
        return AppColors.inProgressStatusColor;
      case "Pending":
        return AppColors.pendingStatusColor;
      case "Accepted":
        return AppColors.greenTextColor;
      case "Re-open":
        return AppColors.reOpenStatusColor;
      case "Completed":
        return AppColors.greenTextColor;
      case "Request for closure":
        return AppColors.issueButtonColor;
      case "Rejected":
        return AppColors.redText;
      default:
        return AppColors.black;
    }
  }
}
