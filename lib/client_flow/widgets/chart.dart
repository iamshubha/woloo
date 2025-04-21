import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/dashboard_task_model.dart';
import 'package:woloo_smart_hygiene/client_flow/widgets/pie_chart.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../core/local/global_storage.dart';
import '../../screens/common_widgets/dropdown_dialogue.dart';
import '../../screens/janitor_details_screen/view/chart.dart';
import '../../utils/app_constants.dart';
import '../screens/dashbaord/bloc/dashboard_bloc.dart';
import '../screens/dashbaord/bloc/dashboard_event.dart';
import '../screens/dashbaord/bloc/dashboard_state.dart';
import '../screens/dashbaord/data/model/facility_dropdown_model.dart';
import '../screens/dashbaord/data/model/task_model.dart';

class Charts extends StatefulWidget {
   final int? facilityId;
  const Charts({super.key, this.facilityId});

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  ClientDashBoardBloc dashBoardBloc = ClientDashBoardBloc();
  DashbaordModel? dashboardModel;
  Map<String, dynamic>? decodedToken;
  GlobalStorage globalStorage = GetIt.instance();
  String? dropdownValue;

  List<Datum> janitorName = [] ;

        List<FacilityDropdownModel> facilitydropdownNames = [];
        FacilityDropdownModel? selectItem;

  String clientId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var some = globalStorage.getClientToken();
     clientId = globalStorage.getClientId();

    decodedToken = JwtDecoder.decode(some);
    dashBoardBloc.add( GetAllJanitorEvent(clientId: int.parse(clientId)));
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),

        SingleChildScrollView(
          child: Container(
            // height: 580.h,
            width: MediaQuery.of(context).size.width / 1.1,
            decoration: BoxDecoration(
                boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2), // Shadow color
                spreadRadius: 1, // How wide the shadow should spread
                blurRadius: 10, // The blur effect of the shadow
                offset: const Offset(0, 0), // No offset for shadow on all sides
              ),
            ],
                color: AppColors.white, borderRadius: BorderRadius.circular(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
          
                BlocConsumer(
                    bloc: dashBoardBloc,
                    listener: (context, state) {
                      print("statesss  $state ");
                      if (state is DashboarLoading) {
                        EasyLoading.show(status: state.message);
                      }
          
                      if (state is DashbaordTask) {
                        EasyLoading.dismiss();
          
                        // dashbaordModel = state.dashbaordModel;
                        // setState(() {
          
                        // });
                      // ;
          
                        // print("$dashbaordModel objectttttttttttt");
                        // print("rasd ${ dashbaordModel!.results!.taskStatusDistribution!
                        //     .completedCount}");
                      }
          
                       if(state is  GetAllJanitor  ){
                         EasyLoading.dismiss();
          
                         janitorName =  state.taskModel!.results.data;
                            for (var janitor in janitorName) {
                         facilitydropdownNames.add( FacilityDropdownModel(
                          facilityName: janitor.name,
                          id: janitor.id,
          
                         ));
          
                            }


                         selectItem =   facilitydropdownNames.first;
          
          
                         dashBoardBloc.add(GetDashbaordEvent(
                             type: "today",
                             clientId: clientId,
                             janitorId: facilitydropdownNames.first.id!,
                             locationId: widget.facilityId!   ));
                          //  facilitydropdown = dashbaordModel.results.
          
                       }
          
                      if (state is DashboarError) {
                        EasyLoading.dismiss();
                        EasyLoading.showError(state.error);
                      }
                    },
                    builder: (context, state) {
          
                       if( state is DashbaordTask ){
          
                         dashboardModel =    state.dashbaordModel;
          
                          print("sdfkhjslkdfjsd ${dashboardModel!.results!.taskStatusDistribution!.ongoingCount} ");
          
                       }
                      // print("statesss  $state ");
          
                      return Column(
                        children: [
                          Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  DashboardConst.taskAudit,
                                  style: AppTextStyle.font20bold,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right : 20),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 0.0),
                                  child:
                                    SizedBox(
                                      width:170.w,
                                      // height: 100,
                                      child: DropDownDialog(
                                        isprop: true,
          
                                        hintTextStyle: AppTextStyle.font10,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 4
                                        ),
          
                                        selected: selectItem,
                                        // "its me",
                                        
                                        //  facilitydropdownNames.first.facilityName,
                                        // selected: clusterNames.first,
                                        // key: _dropDownKey,
                                        // widgetKey: _clusterNameKey,
                                        hint:"Select Task Buddy",
          
                                        items: facilitydropdownNames,
          
                                        itemAsString: (FacilityDropdownModel item) =>
                                        item.facilityName,
                                        onChanged: (FacilityDropdownModel item) {
                                          debugPrint("in drop down ${item.locationName}");
                                          try {
          
                                            dashBoardBloc.add(GetDashbaordEvent(
                                                type: "today",
                                                clientId: clientId,
                                                janitorId: item.id!,
          
          
                                                locationId: widget.facilityId!   ));
          
                                            // locationController.text =   item.locationName!;
                                            // facilityController.text = item.facilityName!;
                                            setState(() {});
          
                                            // clusterId = item..id!;
                                            // reportIssueBloc.add(GetAllFacilityDropdown(
                                            //     clusterId: item.clusterId ?? 0));
                                            //
                                            //   // if(state is GetFacilityDropdownSuccess ){
                                            //     reportIssueBloc.add(GetAllTasksDropdown(
                                            //         clusterId: item.clusterId! ?? 0
                                            //     ));
                                            //   // }else
                                            //    // if( state is  GetTasksDropdownSuccess ){
                                            //      reportIssueBloc.add(GetAllJanitorsDropdown(
                                            //          clusterId: item.clusterId ?? 0));
                                            // }
          
          
                                          } catch (e) {
                                            debugPrint("dropppppp$e");
                                          }
                                        },
                                        validator: (value) =>
                                        value == null
                                            ?
                                            "Please select facility"
                                            : null,
                                      ),
                                    )
                                  // DropdownButton<String>(
                                  //   value: dropdownValue,
                                  //   icon: const Icon( Icons.keyboard_arrow_down,
                                  //    size: 30,
                                  //   ),
                                  //   elevation: 16,
                                  //   onChanged: (newValue) {
                                  //     setState(() {
                                  //       dropdownValue = newValue;
                                  //     });
                                  //   },
                                  //   hint: Text("Select Task Buddy",
                                  //    style: AppTextStyle.font10bold,
                                  //   ),
                                  //   underline: SizedBox(),
          
                                  //   items: <String>['City', 'Country', 'State']
                                  //       .map<DropdownMenuItem<String>>((String value) {
                                  //     return DropdownMenuItem<String>(
                                  //       value: value,
                                  //       child: Text(value),
                                  //     );
                                  //   }).toList(),
                                  // ),
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: ChartPie(
                              complatedTask:
                              dashboardModel == null
                                  ? "0"
                                  :
                              dashboardModel!.results!.taskStatusDistribution!
                                          .completedCount ??
                                      "0",
                              pendingTask: dashboardModel == null
                                  ? "0"
                                  :
                              dashboardModel!.results!.taskStatusDistribution!
                                          .pendingCount ??
                                      "0",
                              totalTask: dashboardModel == null
                                  ? "0"
                                  :
                              dashboardModel!.results!.taskStatusDistribution!
                                  .pendingCount ??
                                  "0",
                              accetedTask: dashboardModel == null
                                  ? "0"
                                  : dashboardModel!.results!.taskStatusDistribution!
                                          .acceptedCount ??
                                      "0",
                              ongoingTask: dashboardModel == null
                                  ? "0"
                                  : dashboardModel!.results!.taskStatusDistribution!
                                          .ongoingCount ??
                                      "0",
                              rejectedTask: "0",
                              rfcTask: "0",
                              complatedPercentage:  dashboardModel == null ? "0"  : dashboardModel!.results!.taskStatusDistribution!.completedPercentage,
                            ),
                          ),
                        ],
                      );
                    }),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),
        //
        // BlocConsumer (
        //   bloc: dashBoardBloc,
        //   listener: (context, state) {
        //     if ( state is DashboarLoading  ){
        //
        //       EasyLoading.show(status: state.message);
        //     }
        //
        //     if (state is DashbaordTask  ) {
        //       EasyLoading.dismiss();
        //
        //       dashbaordModel = state.dashbaordModel;
        //
        //       print("$dashbaordModel objectttttttttttt");
        //     }
        //
        //     if(state is DashboarError  ){
        //       EasyLoading.dismiss();
        //       EasyLoading.showError( state.error.message);
        //
        //     }
        //
        //   },
        //   builder: (context, state) {
        //     return DualBarChart(
        //       value1: dashbaordModel == null ?  [] : dashbaordModel!.results!.janitorEfficiency!.totaltask!
        //           .map((e) => double.tryParse(e.toString()) ?? 0.0) // Convert and handle errors
        //           .toList(),
        //       value2: dashbaordModel == null ?  [] : dashbaordModel!.results!.janitorEfficiency!.closedtask!
        //           .map((e) => double.tryParse(e.toString()) ?? 0.0) // Convert and handle errors
        //           .toList(),
        //     );
        //   }
        // )
      ],
    );
  }
}

class DualBarChart extends StatelessWidget {
  List<double>? value1;
  List<double>? value2;

  DualBarChart({this.value1, this.value2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 400,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2), // Shadow color
          spreadRadius: 1, // How wide the shadow should spread
          blurRadius: 10, // The blur effect of the shadow
          offset: const Offset(0, 0), // No offset for shadow on all sides
        ),
      ], color: AppColors.white, borderRadius: BorderRadius.circular(40)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              DashboardConst.janitorPerformance,
              style: AppTextStyle.font20bold,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 200,
            width: 400,
            child: BarChart(
              BarChartData(
                barGroups: _getBarGroups(value1!, value2!),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  drawHorizontalLine: true,
                  horizontalInterval: 2,
                  getDrawingHorizontalLine: (value) {
                    return const FlLine(color: Colors.grey, strokeWidth: 1);
                  },
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      // interval: 5,
                      reservedSize: 30,
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final labels = [
                          'Janitor',
                          'Janitor 1',
                          'Janitor 2',
                          'Janitor 3',
                          'Janitor 4'
                        ];
                        if (value.toInt() >= 0 &&
                            value.toInt() < labels.length) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              labels[value.toInt()],
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _getBarGroups(
      List<double> total, List<double> closed) {
    final List<double> values1 = total;
    final List<double> values2 = closed;
    return List.generate(values1.length, (index) {
      return BarChartGroupData(
        x: index,
        barsSpace: 0,
        barRods: [
          BarChartRodData(
            toY: values1[index],
            color:
                Colors.blue, // Replace with AppColors.backgroundColor if needed
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
          BarChartRodData(
            toY: values2[index],
            color: const Color(0xff717171),
            width: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }
}
