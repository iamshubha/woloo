// Mock API Service
import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
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
                  Row(
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
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: AppColors.buttonYellowColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 12,
                                    ),
                                  )
                                ],
                              ),
                              Text(
                                "Overall performance",
                                style: TextStyle(
                                    color: AppColors.pieDataColor3,
                                    fontSize: 10.sp),
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
                            summary: data.summary.avgppmTimeRangeInsights),
                      )
                    ],
                  )
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
