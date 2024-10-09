import 'package:Woloo_Smart_hygiene/utils/app_textstyle.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Woloo_Smart_hygiene/screens/common_widgets/empty_list_widget.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/bloc/janitor_list_bloc.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/bloc/janitor_list_event.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/bloc/janitor_list_state.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/data/model/Janitor_list_model.dart';
import 'package:Woloo_Smart_hygiene/screens/janitor_screen/data/model/Reassign_janitor_model.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/bloc/supervisor_dashboard_event.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/bloc/supervisor_dashboard_state.dart';
import 'package:Woloo_Smart_hygiene/screens/supervisor_dashboard/model/Supervisor_model_dashboard.dart';
import 'package:Woloo_Smart_hygiene/utils/app_constants.dart';
import 'package:Woloo_Smart_hygiene/utils/app_images.dart';

import '../../utils/app_color.dart';
import '../supervisor_dashboard/bloc/supervisor_dashboard_bloc.dart';
import 'error_widget.dart';
import 'image_provider.dart';

class JanitorListWidget extends StatefulWidget {
  final TextEditingController controller;
  final bool isFromCluster;
  final bool isFromDashboard;
  final bool isFromFacility;
  final Function onTapItem;
  final String? janitorId;
  List<String> allocationId;
  final String? clusterId;
  final bool isFromDashboardAssignment;

  JanitorListWidget({
    Key? key,
    required this.controller,
    required this.onTapItem,
    required this.isFromCluster,
    required this.isFromDashboard,
    required this.isFromFacility,
    required this.allocationId,
    this.janitorId,
    this.clusterId,
    required this.isFromDashboardAssignment,
  }) : super(key: key);

  @override
  State<JanitorListWidget> createState() => _JanitorListWidgetState();
}

class _JanitorListWidgetState extends State<JanitorListWidget> {
  int selectedCard = -1;

  JanitorListBloc _janitorListBloc = JanitorListBloc();

  List<JanitorListModel> _data = [];
  List<JanitorListModel> _search = [];
  List<SupervisorModelDashboard> _supervisorDashboardData = [];

  late SupervisorDashboardBloc _supervisorDashboardBloc;

  ReassignJanitorModel _reassignJanitorModel = ReassignJanitorModel();
  bool janitorListReloading = false;
  bool dashboardListReloading = false;
  bool isAssigned = false;

  @override
  void initState() {
    _supervisorDashboardBloc = SupervisorDashboardBloc();

    _janitorListBloc.add(GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
    print("janitor_list_clusterId ====> ${widget.clusterId}");
    widget.controller.addListener(() {

      setState(() {
        if (widget.controller.text.isEmpty) {
          _search = _data;
          return;
        }

        _search = _data
            .where((element) =>
                element.name
                    ?.toLowerCase()
                    .contains(widget.controller.text.toLowerCase()) ??
                false)
            .toList();
      print("some $_search");
      _search.map( (e)=> print(" sdds${e.id}")  );
      });
    });
    print(" is dash  ${widget.isFromDashboard}");
    print(" from dash boardassign ment ${widget.isFromDashboardAssignment}");
    print("cluster---->${widget.isFromCluster}");
    print(widget.isFromFacility);
    print("assignment ---->${widget.isFromDashboardAssignment}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _janitorListBloc,
        listener: (context, state) {
          if (state is JanitorListSuccess) {
            EasyLoading.dismiss();
          }

     
        },
        builder: (context, state) {
           print(" janitorssssss $state");

               if( state is  ReassignTaskSuccessful ){
                 if (widget.isFromCluster) {
                   _janitorListBloc
                       .add(GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
                   
                     janitorListReloading = true;
                  

                   Navigator.pop(context);
                   Navigator.pop(context);
                 }
                 if (widget.isFromDashboardAssignment) {
                   _supervisorDashboardBloc.add(GetSupervisorDashboardData());
                
                     dashboardListReloading = true;
                   
                   Navigator.pop(context);
                 }

               }
            if (state is GetSupervisorDashboardDataSuccess) {
            EasyLoading.dismiss();
            
              _supervisorDashboardData = state.data;
              print("GetSupervisorDashboardDataSuccess--->" +
                  _supervisorDashboardData.toString());
          

            if (dashboardListReloading) {
              
          _supervisorDashboardData = state.data;
          
            }
          }


          if (state is JanitorListLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
            return SizedBox();
          } else if (state is JanitorListError) {
            return CustomErrorWidget(error: state.error);
          } else if (state is ReassignTaskLoading) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
            return SizedBox();
          } else if (state is ReassignTaskError) {
            EasyLoading.dismiss();
            return CustomErrorWidget(error: state.error);
          } else if (state is SupervisorDashboardLoading &&
              _supervisorDashboardData.isEmpty) {
            EasyLoading.show(
                status: MydashboardScreenConstants.LOADING_TOAST.tr());
            return SizedBox();
          } else if (state is SupervisorDashboardError) {
            EasyLoading.dismiss();
            print("SupervisorDashboardError--->$_supervisorDashboardData");

            return CustomErrorWidget(error: state.error);
          } else if (state is GetSupervisorDashboardDataSuccess &&
              _supervisorDashboardData.isEmpty) {
            EasyLoading.dismiss();
            print(
                "GetSupervisorDashboardDataSuccess--->$_supervisorDashboardData");

            return const EmptyListWidget();
          } else
            if (state is JanitorListSuccess) {
            EasyLoading.dismiss();
     

                   if(state.fromReassign){
                     // if(_search.isEmpty){
                       _data = state.data;
                       _search = _data;
                     // }
                       _janitorListBloc.add(
                           const ReassignTask(
                               id:[],
                               janitor_id:
                                   '',
                               fromReassign: false
                           ));
                     //   state.fromReassign = false;
                   }
                   else{
                         if(_search.isEmpty){
                           _data = state.data;
                           _search = _data;
                         }
                   }



               // if( _search.isEmpty ){
               //   _data = state.data;
               //      _search = _data;
               // }
               //  print("search ${_search} ");
               //    //  print("search ${} ");
               // if(  state.fromReassign){
               //    _data = state.data;
               //
               //     _search = _data;
               //    print("from reassing ${_search} ");
               //    // _search =_search;
               // }
            if (janitorListReloading) {
              _data = state.data;
              _search = _data;
            }
            if (widget.isFromFacility) {
              _data.removeWhere((element) {
                return element.id == widget.janitorId;
              });
              if( _search.isEmpty ){
                _search = _data;
              }
            }

             print("ssssssss $_search ");
            return 
                _search.isEmpty ? 
            const EmptyListWidget() :     
            RefreshIndicator(
              onRefresh: () {
                return Future.delayed(
                  const Duration(seconds: 1),
                  () {
                    _janitorListBloc.add(
                        GetAllJanitors(cluster_id: widget.clusterId ?? "0"));
                  },
                );
              },
              color: AppColors.buttonColor,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _search.length,
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
                          widget.onTapItem(_search[index]);
                         
                            selectedCard = index;
                     
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
                                ? AppColors.containerColor
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.containerBorder,
                              width: 1.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.h, horizontal: 5.w),
                                  child: Container(
                                    height: 40.h,
                                    width: 40.w,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.darkGreyColor),
                                    child: const Icon(
                                      Icons.person_2_outlined,
                                      color: AppColors.buttonColor,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().screenWidth - 120.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5.w,
                                                vertical: 2.h,
                                              ),
                                              child: Text(
                                                  _search[index].name ?? '',
                                                  style: AppTextStyle.font18
                                                      .copyWith(
                                                    color: AppColors
                                                        .janitorNameColor,
                                                  )
                                                  //  TextStyle(
                                                  //   color:
                                                  //       AppColors.janitorNameColor,
                                                  //   fontSize: 18.sp,
                                                  //   fontWeight: FontWeight.w400,
                                                  // ),
                                                  ),
                                            ),
                                          ),
                                          if (widget.isFromCluster ||
                                              widget
                                                  .isFromDashboardAssignment) ...[
                                            _search[index].isPresent == true
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 20.w,
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomImageProvider(
                                                          image: AppImages
                                                              .janitor_present,
                                                          height: 20.h,
                                                          width: 20.w,
                                                        ),
                                                        Text(
                                                            MyJanitorsListScreenConstants
                                                                .JANITOR_PRESENT
                                                                .tr(),
                                                            style: AppTextStyle
                                                                .font12
                                                                .copyWith(
                                                              color: AppColors
                                                                  .greenText,
                                                            )
                                                            // TextStyle(
                                                            //     color: AppColors
                                                            //         .greenText,
                                                            //     fontSize: 12.sp,
                                                            //     fontWeight:
                                                            //         FontWeight
                                                            //             .w400),
                                                            )
                                                      ],
                                                    ),
                                                  )
                                                : Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CustomImageProvider(
                                                        image: AppImages
                                                            .janitor_absent,
                                                        height: 20.h,
                                                        width: 20.w,
                                                      ),
                                                      Text(
                                                          MyJanitorsListScreenConstants
                                                              .JANITOR_ABSENT
                                                              .tr(),
                                                          style: AppTextStyle
                                                              .font12
                                                              .copyWith(
                                                            color: AppColors
                                                                .redText,
                                                          )
                                                          //  TextStyle(
                                                          //     color:
                                                          //         AppColors.redText,
                                                          //     fontSize: 12.sp,
                                                          //     fontWeight:
                                                          //         FontWeight.w400),
                                                          )
                                                    ],
                                                  )
                                          ],
                                          if (widget.isFromFacility) ...[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w),
                                              child: InkWell(
                                                onTap: () {
                                                  _janitorListBloc.add(
                                                      ReassignTask(
                                                          id: widget
                                                              .allocationId,
                                                          janitor_id:
                                                              _data[index].id ??
                                                                  '',
                                                           fromReassign: true       
                                                                  ));
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                    color:
                                                        AppColors.buttonColor,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 8.w,
                                                      vertical: 8.h,
                                                    ),
                                                    child: Text(
                                                        MyClusterListScreenConstants
                                                            .BTN_TEXT
                                                            .tr(),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: AppTextStyle
                                                            .font12
                                                            .copyWith(
                                                          color: Colors.black,
                                                        )
                                                        //  TextStyle(
                                                        //   fontSize: 12.sp,
                                                        //   fontWeight:
                                                        //       FontWeight.w400,
                                                        //   color: Colors.black,
                                                        // ),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                          "Mob.no. ${_search[index].mobile ?? ''}",
                                          style: AppTextStyle.font12.copyWith(
                                            color: AppColors.clusterTitleColor,
                                          )
                                          // TextStyle(
                                          //   color: AppColors.clusterTitleColor,
                                          //   fontSize: 12.sp,
                                          //   fontWeight: FontWeight.w400,
                                          // ),
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                          _search[index].clusterName ?? '',
                                          style: AppTextStyle.font14.copyWith(
                                            color: AppColors.clusterTitleColor,
                                          )

                                          //  TextStyle(
                                          //   color: AppColors.clusterTitleColor,
                                          //   fontSize: 14.sp,
                                          //   fontWeight: FontWeight.w500,
                                          // ),
                                          ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.w,
                                        vertical: 2.h,
                                      ),
                                      child: Text(
                                          "Pin code : ${_search[index].pincode ?? ''}",
                                          style: AppTextStyle.font12.copyWith(
                                            color: AppColors.clusterTitleColor,
                                          )
                                          //  TextStyle(
                                          //   color: AppColors.clusterTitleColor,
                                          //   fontSize: 12.sp,
                                          //   fontWeight: FontWeight.w400,
                                          // ),
                                          ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                              "Total task :${_search[index].totalTaskCount ?? ''}",
                                              style: AppTextStyle.font12w5
                                                  .copyWith(
                                                color: AppColors.greenTextColor,
                                              )

                                              // TextStyle(
                                              //   color: AppColors.greenTextColor,
                                              //   fontSize: 12.sp,
                                              //   fontWeight: FontWeight.w500,
                                              // ),
                                              ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5.w,
                                            vertical: 2.h,
                                          ),
                                          child: Text(
                                              "Pending task : ${_search[index].pendingTaskCount ?? ''}",
                                              style: AppTextStyle.font12w5
                                                  .copyWith(
                                                color: AppColors.redTextColor,
                                              )
                                              //  TextStyle(
                                              //   color: AppColors.redTextColor,
                                              //   fontSize: 12.sp,
                                              //   fontWeight: FontWeight.w500,
                                              // ),
                                              ),
                                        ),
                                      ],
                                    ),
                                    if (widget.isFromDashboardAssignment &&
                                        _search[index].isPresent == true) ...[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.w, vertical: 5.h),
                                        child: InkWell(
                                          onTap: () {
                                            _janitorListBloc.add(
                                              ReassignTask(
                                                  id: widget.allocationId,
                                                  janitor_id:
                                                  _search[index].id ?? '',
                                                    fromReassign: true
                                                  ),
                                            );
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
                                                vertical: 8.h,
                                              ),
                                              child: Text(
                                                  MyClusterListScreenConstants
                                                      .BTN_TEXT
                                                      .tr(),
                                                  textAlign: TextAlign.center,
                                                  style: AppTextStyle.font12
                                                      .copyWith(
                                                    color: Colors.black,
                                                  )
                                                  // TextStyle(
                                                  //   fontSize: 12.sp,
                                                  //   fontWeight: FontWeight.w400,
                                                  //   color: Colors.black,
                                                  // ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            );
         //   const EmptyListWidget();
          } 
          else 
          {
            return SizedBox();
          }
        });
  }
}

