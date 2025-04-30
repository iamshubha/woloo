// Mock API Service
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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

class ApiService {
  Future<DashboardData> fetchDashboardData({required String timeFilter}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return the actual data
    return DashboardData.fromJson({
      "results": {
        "gauge_graph_data": {
          "avg_amonia": "482.26",
          "pcd_max": "190.44",
          "ppm": {},
          "condition": "Moderate"
        },
        "ammonia_level_across_washroom_result": {
          "distinct_data_modified": {
            "data": [
              {"color": "#000000", "y": 394},
              {"color": "#EF4444", "y": 753}
            ],
            "category": ["Gannaur HRF022", "Meerut Road HRF078"]
          },
          "distinct_people_data_modified": {
            "data": [
              {"color": "#000000", "y": 223},
              {"color": "#000000", "y": 36}
            ],
            "category": ["Gannaur HRF022", "Meerut Road HRF078"]
          },
          "distinct_people_data_unit": "Building"
        },
        "alerts_notification": [
          {
            "ppm_time": "2025-04-17 02:15:26",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 00:01:07",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 09:15:30",
            "condition": "good",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 06:30:30",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 06:44:34",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 07:16:59",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 09:45:38",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 07:45:06",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 12:45:35",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-17 11:03:07",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-17 18:47:53",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 18:47:53",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 18:47:53",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 19:42:07",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 19:42:07",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-17 19:46:08",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 05:15:06",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-18 05:29:09",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-18 07:30:40",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 07:00:32",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 10:44:32",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-18 17:30:55",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-18 18:32:04",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 18:48:48",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 20:40:38",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-18 22:59:49",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-19 02:44:45",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 06:59:22",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 06:01:07",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 05:31:47",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 19:03:18",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 16:30:50",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-19 14:46:11",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 22:45:01",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 05:58:58",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 19:46:07",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 05:45:03",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 05:15:42",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 08:00:11",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-19 21:34:09",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 21:00:00",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 20:16:23",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-19 21:46:12",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 03:59:25",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 03:59:25",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 06:30:33",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 07:00:24",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 14:16:40",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 18:31:46",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 18:35:48",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 21:16:29",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 21:00:25",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-20 21:20:32",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 03:14:30",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 00:43:51",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 03:44:38",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 06:42:53",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 07:00:04",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 10:46:20",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 06:30:49",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 06:45:24",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 17:00:28",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 17:14:31",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-21 18:44:23",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 21:58:49",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-21 19:30:35",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-22 05:43:55",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-22 05:59:33",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-22 11:29:25",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-22 09:30:53",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-22 14:06:08",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-22 12:45:45",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-23 09:11:36",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-23 18:35:50",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-20 19:14:26",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-20 19:15:59",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-23 06:59:12",
            "condition": "bad",
            "data_unit": "Meerut Road HRF078"
          },
          {
            "ppm_time": "2025-04-23 08:45:29",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-23 16:15:11",
            "condition": "good",
            "data_unit": "Gannaur HRF022"
          },
          {
            "ppm_time": "2025-04-23 18:43:52",
            "condition": "bad",
            "data_unit": "Gannaur HRF022"
          }
        ],
        "amonia_table_data": [
          {
            "pcd_max": "223.0000000000000000",
            "ppm_avg": "394.0000000000000000",
            "heading": "Gannaur HRF022",
            // "ppm_diff": -356,
            "value": [
              396.0921052631579,
              471.38961038961037,
              436.7926829268293,
              245.87368421052631,
              628.6559139784946,
              324.9894736842105,
              431.1645569620253,
              0.98
            ]
          },
          {
            "pcd_max": "36.5000000000000000",
            "ppm_avg": "753.0000000000000000",
            "heading": "Meerut Road HRF078",
            // "ppm_diff": 3,
            "value": [
              406.7736842105263,
              353.4935897435897,
              450.5217391304348,
              488.0851063829787,
              358.0520833333333,
              230.53157894736842,
              253.56716417910448,
              0
            ]
          }
        ],
        "ammonia_unit": "ppb",
        "range_of_ppm": {
          "unhealthy_max": "6000.0000000000000000",
          "unhealthy_min": "750.0000000000000000",
          "healthy_min": "0.00000000000000000000",
          "healthy_max": "225.0000000000000000",
          "moderate_max": "750.0000000000000000",
          "moderate_min": "225.0000000000000000"
        },
        "avgppm_time_range": [
          {
            "time_range": "12-3 AM",
            "avg_ppm_avg": "333.2083333333333333",
            "avg_ppm_max": "563.2083333333333333",
            "avg_pcd_max": "5.6958333333333333",
            "avg_pch_max": "1.8083333333333333"
          },
          {
            "time_range": "3-6 AM",
            "avg_ppm_avg": "387.5299145299145299",
            "avg_ppm_max": "807.7435897435897436",
            "avg_pcd_max": "14.5299145299145299",
            "avg_pch_max": "2.1709401709401709"
          },
          {
            "time_range": "6-9 AM",
            "avg_ppm_avg": "467.0675675675675676",
            "avg_ppm_max": "1070.1216216216216216",
            "avg_pcd_max": "33.9189189189189189",
            "avg_pch_max": "4.3198198198198198"
          },
          {
            "time_range": "9-12 AM",
            "avg_ppm_avg": "457.9689119170984456",
            "avg_ppm_max": "926.9378238341968912",
            "avg_pcd_max": "66.5388601036269430",
            "avg_pch_max": "5.8756476683937824"
          },
          {
            "time_range": "12-3 PM",
            "avg_ppm_avg": "358.8324873096446701",
            "avg_ppm_max": "836.9847715736040609",
            "avg_pcd_max": "101.8680203045685279",
            "avg_pch_max": "7.4467005076142132"
          },
          {
            "time_range": "3-6 PM",
            "avg_ppm_avg": "276.9238578680203046",
            "avg_ppm_max": "662.9390862944162437",
            "avg_pcd_max": "135.8629441624365482",
            "avg_pch_max": "6.3705583756345178"
          },
          {
            "time_range": "6-9 PM",
            "avg_ppm_avg": "470.1538461538461538",
            "avg_ppm_max": "1270.7067307692307692",
            "avg_pcd_max": "168.0673076923076923",
            "avg_pch_max": "7.2211538461538462"
          },
          {
            "time_range": "9-12 PM",
            "avg_ppm_avg": "387.1212121212121212",
            "avg_ppm_max": "723.5353535353535354",
            "avg_pcd_max": "195.3787878787878788",
            "avg_pch_max": "3.4343434343434343"
          }
        ],
        "summary": {
          "alerts_notification_summary":
              "Alerts notification data for location wise for the last 7 days. This graph shows the number of alerts for bad ammonia level triggered during the specified period.",
          "avgppm_over_location":
              "Average air quality data for location wise for the last 7 days. This graph illustrates the average air quality across location.",
          "avgppm_time_range_insights":
              "Average PPM time range insights for location wise for the last 7 days. Air quality vs usage graph shares the insights for location wise air quality and usage data for the current day"
        }
      },
      "success": true
    });
  }
}

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
  String _error = '';
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
                      style: const TextStyle(
                          color: AppColors.textgreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      children: [
                        const TextSpan(
                          text: 'Your Trial shall end in ',
                        ),
                        TextSpan(
                          text: '3 Days. ',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const TextSpan(
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
                  AlertAndNotificationWidget(data: data)
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
