import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/main.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../client_flow/screens/dashbaord/bloc/dashboard_bloc.dart';
import '../../client_flow/screens/dashbaord/data/model/facility_model.dart';
import '../../client_flow/widgets/chart.dart';
import '../model/iotdata_model.dart';
import '../widgets/ai_summary.dart';
import '../widgets/alert_notification.dart';
import 'bloc/iot_bloc.dart';
import 'bloc/iot_event.dart';
import 'bloc/iot_state.dart';

class DashboardScreen extends StatefulWidget {
  final int? facilityId;
  final String? plan;
  final String? status;
  final int? tabIndex;
  final TabController? tabController;
  final List<Facility>? facility;
  final ClientDashBoardBloc? clientDashBoardBloc;

  const DashboardScreen(
      {super.key,
      this.facility,
      this.clientDashBoardBloc,
      this.facilityId,
      this.plan,
      this.status,
      this.tabController,
      this.tabIndex});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  IotBloc iotBloc = IotBloc();
  final int _selectedIndex = 0;
  DashboardData? _dashboardData;
  // bool _isLoading = false;
  final String _error = '';
  String _timeFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    // _fetchDashboardData();
    iotBloc.add(const GetIot(
      deviceId: 'deviceId',
      type: 'type',
    )); // Replace with actual device ID and type
  }

  void _setTimeFilter(String filter) {
    if (_timeFilter != filter) {
      setState(() {
        _timeFilter = filter;
      });
      // _fetchDashboardData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: iotBloc,
      listener: (context, state) {
        print("dssa $state");
        if (state is IotLoading) {
          EasyLoading.show(status: state.message);
        }
        if (state is IotSuccess) {
          EasyLoading.dismiss();
          setState(() {
            _dashboardData = state.dashboardData;
            // _isLoading = false;
          });
        }

        if (state is IotError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.error);
        }
      },
      builder: (context, state) {
        // if (_isLoading && _dashboardData == null) {
        //   return const Center(child: CircularProgressIndicator());
        // }

        if (_error.isNotEmpty && _dashboardData == null) {
          return Center(
            child: Text('Error: $_error'),
          );
        }

        final data = _dashboardData;
        if (data == null) {
          return const Center(child: Text('No data available'));
        }

        return SingleChildScrollView(
          // physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(14.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // RichText(
              //   text: const TextSpan(
              //     style: TextStyle(
              //         color: AppColors.textgreyColor,
              //         fontSize: 14,
              //         fontWeight: FontWeight.w700),
              //     children: [
              //       TextSpan(
              //         text: 'Your Trial shall end in ',
              //       ),
              //       TextSpan(
              //         text: '3 Days. ',
              //         style: TextStyle(fontWeight: FontWeight.bold),
              //       ),
              //       TextSpan(
              //         text: 'Renew it Now',
              //         style: TextStyle(
              //           color: AppColors.textgreyColor,
              //           fontWeight: FontWeight.bold,
              //           decoration: TextDecoration.underline,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Dashboard Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AppImages.tuneLogo,
                      )),
                ],
              ),
              const SizedBox(height: 16),
              const CustomChartWidget(),
              // AirQualityChart(
              //   airQualityData: data.avgppmTimeRange.map((e) {
              //     // var d = (e.avgPcdMax.runtimeType);

              //     return GraphData(
              //       airQuality: double.parse(e.avgPpmAvg),
              //       usage: double.parse(e.avgPcdMax),
              //       timeRange: e.timeRange,
              //     );
              //   }).toList(),
              //   isLoading: false,
              //   timeFilter: _timeFilter,
              //   onFilterChanged: _setTimeFilter,
              // ),
              const SizedBox(height: 16),
              AiSummaryCard(summary: data.summary.avgppmTimeRangeInsights),
              const SizedBox(height: 16),
              Charts(
                facilityId: widget.facilityId,
                plan: widget.plan,
                status: widget.plan,
                tabIndex: widget.tabIndex,
                facility: widget.facility,
                clientDashBoardBloc: widget.clientDashBoardBloc,
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: 0.2), // Shadow color
                          spreadRadius: 1, // How wide the shadow should spread
                          blurRadius: 10, // The blur effect of the shadow
                          offset: const Offset(
                              0, 0), // No offset for shadow on all sides
                        ),
                      ],
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(40)),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Usage Report",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const CustomBarChart(),
                      const Divider(),
                      Row(
                        spacing: 20,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: AppColors.appBarTitleColor,
                            child: Image.asset("assets/images/bxs_smile.png"),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You are doing good!",
                                style: TextStyle(
                                  color: AppColors.alertTitleColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "You almost reached your goal",
                                style: TextStyle(
                                  color: AppColors.alertTitleColor,
                                  fontSize: 10.sp,
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              AlertAndNotificationWidget(data: data),
              const SizedBox(height: 16),
              AirQuality(data: data),

              const SizedBox(height: 16),
              const Facilities(),
              const SizedBox(height: 16),
              AiSummaryCard(summary: data.summary.avgppmTimeRangeInsights),
              const SizedBox(height: 120),
            ],
          ),
        );
      },
    );
  }
}

class AirQuality extends StatelessWidget {
  const AirQuality({
    super.key,
    required this.data,
  });

  final DashboardData? data;

  @override
  Widget build(BuildContext context) {
    var pies = [
      PieData(value: 25, color: Colors.grey),
      PieData(value: 35, color: Colors.lightBlueAccent),
      PieData(value: 25, color: Colors.grey.shade300),
      PieData(value: 25, color: Colors.cyanAccent.shade200),
    ];
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: XDecoratedBox(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Air Quality Level",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const ForwardButton()
                    ],
                  ),
                  Text(
                    "Overall performance",
                    style: TextStyle(
                        color: AppColors.pieDataColor3, fontSize: 10.sp),
                  ),
                  const SizedBox(
                      height: 120,
                      width: 120,
                      child: ComplexCircularBar(
                        percentageValue: 65,
                        performance: 1.5,
                      )),
                  Text(
                    "Average AQL across all facilities",
                    style: TextStyle(fontSize: 8.sp),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          // Expanded(
          //   child: AiSummaryCard(
          //       fontSize: 14,
          //       summary: data?.summary.avgppmTimeRangeInsights ?? ""),
          // )
          Expanded(
            child: XDecoratedBox(
              child: Column(
                spacing: 10,
                children: [
                  Row(
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      // const ForwardButton()
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 15,
                        color: AppColors.greyBorderProfile,
                      ),
                      const Spacer(),
                      Text(
                        "July 2024",
                        style: TextStyle(
                            fontSize: 10.sp, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 15,
                        color: AppColors.greyBorderProfile,
                      ),
                    ],
                  ),
                  EasyPieChart(
                    borderWidth: 14,
                    key: const Key('pie 2'),
                    children: pies,
                    pieType: PieType.crust,
                    showValue: false,

                    // borderEdge: StrokeCap.round,
                    // style: const TextStyle(
                    //     fontSize: 14,
                    //     fontWeight: FontWeight.bold,
                    //     color: AppColors.black,
                    //     // color: textColor,
                    //     overflow: TextOverflow.visible),
                    onTap: (index) {
                      //  showValue  = !showValue;
                      // // tapIndex = index.toString();
                      // setState(() {});
                    },
                    gap: 6,
                    start: 0,
                    animateFromEnd: true,
                    size: 100,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // const SizedBox(
                        //   height: 100,
                        // ),

                        Text(
                          "4.5",
                          style: AppTextStyle.font12bold,
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          "Excellent",
                          style:
                              AppTextStyle.font10.copyWith(color: Colors.grey),
                        ),

                        // Text(
                        //   "Efficiency",
                        //   style: AppTextStyle.font20bold,
                        // ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Facilities extends StatelessWidget {
  const Facilities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XDecoratedBox(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Facilities",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              const ForwardButton(),
            ],
          ),
          const Row(
            spacing: 15,
            children: [
              Spacer(),
              Column(
                children: [
                  Icon(
                    Icons.home,
                    color: AppColors.lightCyanColor,
                    size: 35,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    "Watchlist",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Daily Average"),
                ],
              ),
              Column(
                children: [
                  Icon(
                    Icons.person,
                    color: AppColors.lightCyanColor,
                    size: 35,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Spacer(),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10),
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: 1,
                itemBuilder: (c, i) {
                  return Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Facility ${i + 1}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "Know More",
                              style: TextStyle(
                                  decoration: TextDecoration.underline),
                            )
                          ],
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        Expanded(
                          flex: 3,
                          child: SizedBox(
                            height: 60, // Specific height
                            child: LineChart(
                              LineChartData(
                                gridData: const FlGridData(show: false),
                                titlesData: const FlTitlesData(
                                  leftTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  rightTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                  bottomTitles: AxisTitles(
                                      sideTitles:
                                          SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    isCurved: false,
                                    spots: [
                                      const FlSpot(0, 1),
                                      const FlSpot(1, 3),
                                      const FlSpot(2, 1.5),
                                      const FlSpot(3, 4),
                                      const FlSpot(4, 3),
                                      const FlSpot(5, 4.5),
                                      const FlSpot(6, 3.5),
                                    ],
                                    color: Colors.blue,
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.lightCyanColor,
                                          AppColors.lightCyanColor
                                              .withValues(alpha: 0.0)
                                        ],
                                        // stops: const [0.1, 0.5],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    dotData: const FlDotData(show: false),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("0.8"),
                        const Spacer(
                          flex: 1,
                        ),
                        const Icon(Icons.arrow_upward_rounded)
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  const ForwardButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: AppColors.buttonYellowColor,
          borderRadius: BorderRadius.circular(8)),
      child: const Icon(
        Icons.arrow_forward_ios_rounded,
        size: 12,
      ),
    );
  }
}

class ComplexCircularBar extends StatefulWidget {
  const ComplexCircularBar(
      {super.key, required this.percentageValue, required this.performance});
  final double percentageValue;
  final double performance;
  @override
  State<ComplexCircularBar> createState() => _ComplexCircularBarState();
}

class _ComplexCircularBarState extends State<ComplexCircularBar> {
  final ValueNotifier<double> _valueNotifier = ValueNotifier<double>(37.0);
  @override
  void initState() {
    super.initState();
    _valueNotifier.value = widget.percentageValue;
  } // Initial progress value

  @override
  Widget build(BuildContext context) {
    return DashedCircularProgressBar.aspectRatio(
      aspectRatio: 1, // width ÷ height
      valueNotifier: _valueNotifier,
      progress: _valueNotifier.value,
      startAngle: 225,
      sweepAngle: 270,
      foregroundColor: AppColors.pieDataColor3,
      backgroundColor: AppColors.lightCyanColor,
      foregroundStrokeWidth: 16,
      backgroundStrokeWidth: 8,
      animation: true,
      seekSize: 6,
      seekColor: Colors.transparent,
      child: Center(
        child: ValueListenableBuilder(
          valueListenable: _valueNotifier,
          builder: (_, double value, __) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 10.r,
                child: const Icon(
                  Icons.person,
                  size: 15,
                  color: AppColors.pieDataColor3,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.performance.toStringAsFixed(1),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLineChart extends StatelessWidget {
  const CustomLineChart({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false), // Hide grid lines
          titlesData: const FlTitlesData(show: false), // Hide axis titles
          borderData: FlBorderData(show: false), // Hide borders
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 1.5),
                const FlSpot(2, 1.2),
                const FlSpot(3, 1.8),
                const FlSpot(4, 1.5),
                const FlSpot(5, 2),
              ], // Data points for the graph
              isCurved: true, // Smooth curve
              // colors: [Colors.lightBlue], // Line color
              barWidth: 3, // Line thickness
              isStrokeCapRound: true, // Rounded line ends
              belowBarData: BarAreaData(
                show: true,
              ),
            ),
          ],
          minX: 0,
          maxX: 5,
          minY: 0,
          maxY: 2.5,
        ),
      ),
    );
  }
}
