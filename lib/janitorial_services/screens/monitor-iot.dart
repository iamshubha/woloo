// Mock API Service
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../model/iotdata_model.dart';
import '../widgets/ai_summary.dart';
import '../widgets/air_quality_chart.dart';
import '../widgets/alert_notification.dart';
import 'bloc/iot_bloc.dart';
import 'bloc/iot_event.dart';
import 'bloc/iot_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  IotBloc iotBloc = IotBloc();
  int _selectedIndex = 0;
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
    return Scaffold(
      appBar: AppBar(
        leading: CustomImageProvider(
          image: AppImages.dashlogo,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Hello clientName",
              style: AppTextStyle.font14bold,
            ),
            Text(
              DashboardConst.currentDateTime,
              style: AppTextStyle.font12,
            )
          ],
        ),
      ),
      body: SafeArea(
        child: BlocConsumer(
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
              padding: const EdgeInsets.all(14.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                          color: AppColors.textgreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                          text: 'Your Trial shall end in ',
                        ),
                        TextSpan(
                          text: '3 Days. ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                          text: 'Renew it Now',
                          style: TextStyle(
                            color: AppColors.textgreyColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  AirQualityChart(
                    airQualityData: data.avgppmTimeRange.map((e) {
                      // var d = (e.avgPcdMax.runtimeType);

                      return GraphData(
                        airQuality: double.parse(e.avgPpmAvg),
                        usage: double.parse(e.avgPcdMax),
                        timeRange: e.timeRange,
                      );
                    }).toList(),
                    isLoading: false,
                    timeFilter: _timeFilter,
                    onFilterChanged: _setTimeFilter,
                  ),
                  const SizedBox(height: 16),
                  AiSummaryCard(summary: data.summary.avgppmTimeRangeInsights),
                  const SizedBox(height: 16),
                  AlertAndNotificationWidget(data: data),
                  const SizedBox(height: 16),
                  AirQuality(data: data),
                  const SizedBox(height: 16),
                  const Facilities(),
                  const SizedBox(height: 16),
                  AiSummaryCard(summary: data.summary.avgppmTimeRangeInsights),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
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
    return Row(
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
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
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
        Expanded(
          child: AiSummaryCard(
              fontSize: 14,
              summary: data?.summary.avgppmTimeRangeInsights ?? ""),
        )
      ],
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
                itemCount: 3,
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
