import 'dart:math';

import 'package:flutter/material.dart';
// lib/widgets/header_section.dart

import 'package:intl/intl.dart';
// lib/widgets/air_quality_chart.dart

import 'package:fl_chart/fl_chart.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

// import '../models/air_quality_data.dart';
// lib/widgets/ai_summary_card.dart

// lib/models/air_quality_data.dart
class AirQualityData {
  final DateTime timestamp;
  final double airQuality;
  final double usage;
  final double threshold;

  AirQualityData({
    required this.timestamp,
    required this.airQuality,
    required this.usage,
    this.threshold = 50.0,
  });

  factory AirQualityData.fromJson(Map<String, dynamic> json) {
    return AirQualityData(
      timestamp: DateTime.parse(json['timestamp']),
      airQuality: json['air_quality'].toDouble(),
      usage: json['usage'].toDouble(),
      threshold: json['threshold']?.toDouble() ?? 50.0,
    );
  }
}

// lib/models/alert.dart
class Alert {
  final DateTime timestamp;
  final String condition;
  final String building;

  Alert({
    required this.timestamp,
    required this.condition,
    required this.building,
  });

  factory Alert.fromJson(Map<String, dynamic> json) {
    return Alert(
      timestamp: DateTime.parse(json['timestamp']),
      condition: json['condition'],
      building: json['building'],
    );
  }
}

// lib/models/dashboard_data.dart
class DashboardData {
  final String username;
  final String userRole;
  final DateTime lastUpdated;
  final int trialDaysLeft;
  final List<AirQualityData> airQualityData;
  final String aiSummary;
  final List<Alert> alerts;

  DashboardData({
    required this.username,
    required this.userRole,
    required this.lastUpdated,
    required this.trialDaysLeft,
    required this.airQualityData,
    required this.aiSummary,
    required this.alerts,
  });

  factory DashboardData.fromJson(Map<String, dynamic> json) {
    return DashboardData(
      username: json['username'],
      userRole: json['user_role'],
      lastUpdated: DateTime.parse(json['last_updated']),
      trialDaysLeft: json['trial_days_left'],
      airQualityData: (json['air_quality_data'] as List)
          .map((data) => AirQualityData.fromJson(data))
          .toList(),
      aiSummary: json['ai_summary'],
      alerts: (json['alerts'] as List)
          .map((alert) => Alert.fromJson(alert))
          .toList(),
    );
  }
}

// Mock API Service
class ApiService {
  Future<DashboardData> fetchDashboardData({required String timeFilter}) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate sample air quality data points for the last 24 hours
    final now = DateTime.now();
    final List<AirQualityData> airQualityData = List.generate(12, (index) {
      final time = now.subtract(Duration(hours: 2 * (11 - index)));
      return AirQualityData(
        timestamp: time,
        airQuality: 30 + (index * 3) + (Random().nextDouble() * 10),
        usage: 100 + (Random().nextDouble() * 150),
        threshold: 50.0,
      );
    });

    // Generate sample alerts
    final List<Alert> alerts = [
      Alert(
        timestamp: now.subtract(const Duration(hours: 2)),
        condition: "High Air Quality Alert",
        building: "Building A",
      ),
      Alert(
        timestamp: now.subtract(const Duration(hours: 5)),
        condition: "Usage Threshold Exceeded",
        building: "Building B",
      ),
    ];

    return DashboardData(
      username: "John Doe",
      userRole: "Facility Manager",
      lastUpdated: now,
      trialDaysLeft: 15,
      airQualityData: airQualityData,
      aiSummary:
          "Air quality has been maintaining optimal levels throughout the day. There was a slight increase in usage during peak hours (2-4 PM). Recommended to monitor Building B's ventilation system.",
      alerts: alerts,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  DashboardData? _dashboardData;
  bool _isLoading = false;
  String _error = '';
  String _timeFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
  }

  Future<void> _fetchDashboardData() async {
    setState(() {
      _isLoading = true;
      _error = '';
    });

    try {
      // Simulate API call for now
      await Future.delayed(const Duration(seconds: 1));
      final data = await ApiService()
          .fetchDashboardData(timeFilter: _timeFilter.toLowerCase());
      setState(() {
        _dashboardData = data;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setTimeFilter(String filter) {
    if (_timeFilter != filter) {
      setState(() {
        _timeFilter = filter;
      });
      _fetchDashboardData();
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
        child: Builder(
          builder: (context) {
            if (_isLoading && _dashboardData == null) {
              return const Center(child: CircularProgressIndicator());
            }

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
                    text: TextSpan(
                      style: const TextStyle(
                          color: AppColors.textgreyColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      children: [
                        const TextSpan(
                          text: 'Your Trial shall end in ',
                        ),
                        TextSpan(
                          text: '${data.trialDaysLeft} Days. ',
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
                    airQualityData: data.airQualityData,
                    isLoading: _isLoading,
                    timeFilter: _timeFilter,
                    onFilterChanged: _setTimeFilter,
                  ),
                  const SizedBox(height: 16),
                  AiSummaryCard(summary: data.aiSummary),
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

class AiSummaryCard extends StatelessWidget {
  final String summary;

  const AiSummaryCard({
    super.key,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'AI Summary ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                height: 24,
                width: 24,
                child: Image.asset(AppImages.twinkleLogo),
              ),
            ],
          ),
          const SizedBox(height: 12),
          summary.isEmpty
              ? const Text('[Summary here]',
                  style: TextStyle(color: Colors.grey))
              : Text(
                  summary,
                  style: const TextStyle(fontSize: 14),
                ),
        ],
      ),
    );
  }
}

class AirQualityChart extends StatelessWidget {
  final List<AirQualityData> airQualityData;
  final bool isLoading;
  final String timeFilter;
  final Function(String) onFilterChanged;

  const AirQualityChart({
    super.key,
    required this.airQualityData,
    required this.isLoading,
    required this.timeFilter,
    required this.onFilterChanged,
  });

  String _formatTimeRange(DateTime time) {
    final hour = time.hour;

    if (hour >= 8 && hour < 10) return '8-10';
    if (hour >= 10 && hour < 12) return '10-12';
    if (hour >= 12 && hour < 14) return '12-2';
    if (hour >= 14 && hour < 16) return '2-4';
    if (hour >= 16 && hour < 18) return '4-6';
    if (hour >= 18 && hour < 20) return '6-8';

    return '${hour % 12}-${(hour + 2) % 12}';
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final chartHeight = screenSize.height * 0.3; // 30% of screen height

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Air Quality vs Usage',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildFilterButton('ALL', timeFilter),
                      _buildFilterButton('1M', timeFilter),
                      _buildFilterButton('6M', timeFilter),
                      Container(
                        width: 20,
                        height: 20,
                        margin: const EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(
                          color: AppColors.yellowIcon,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: chartHeight,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : LineChart(
                    _buildLineChartData(screenSize),
                  ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Air Quality', Colors.blue),
                const SizedBox(width: 24),
                _buildLegendItem('Usage', Colors.amber),
                const SizedBox(width: 24),
                Row(
                  children: [
                    Container(
                      width: 16,
                      height: 2,
                      color: Colors.red,
                      margin: const EdgeInsets.only(right: 8),
                    ),
                    const Text(
                      'Threshold (50 ppm)',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String filter, String currentFilter) {
    final isSelected = filter == currentFilter;

    return GestureDetector(
      onTap: () => onFilterChanged(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
            color: isSelected ? Colors.grey[300] : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: Colors.grey.shade300)),
        child: Text(
          filter,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  LineChartData _buildLineChartData(Size screenSize) {
    // Create spots for the two lines
    final List<FlSpot> airQualitySpots = [];
    final List<FlSpot> usageSpots = [];

    for (int i = 0; i < airQualityData.length; i++) {
      final data = airQualityData[i];
      airQualitySpots.add(FlSpot(i.toDouble(), data.airQuality));
      usageSpots.add(FlSpot(i.toDouble(), data.usage / 5));
    }

    final isSmallScreen = screenSize.width < 360;
    final fontSize = isSmallScreen ? 10.0 : 12.0;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 15,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey[300],
            strokeWidth: 0.5,
            // dashArray: [5, 5],
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.grey[400],
            strokeWidth: 1,
            dashArray: [5, 5],
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 50,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.left,
              );
            },
            // reservedSize: 35,
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
            interval: isSmallScreen ? 2 : 1,
            getTitlesWidget: (value, meta) {
              if (value.toInt() >= airQualityData.length) {
                return const Text('');
              }

              final time = airQualityData[value.toInt()].timestamp;
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: RotatedBox(
                  quarterTurns: isSmallScreen ? 1 : 0,
                  child: Text(
                    _formatTimeRange(time),
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 15,
            getTitlesWidget: (value, meta) {
              return Text(
                value.toInt().toString(),
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: fontSize,
                ),
                textAlign: TextAlign.left,
              );
            },
            // reservedSize: 35,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      minX: 0,
      maxX: (airQualityData.length - 1).toDouble(),
      minY: 0,
      maxY: 75,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
          tooltipRoundedRadius: 8,
          tooltipPadding: const EdgeInsets.all(8),
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((spot) {
              final data = airQualityData[spot.x.toInt()];
              final isAirQuality = spot.barIndex == 0;
              final value = isAirQuality ? spot.y : (spot.y * 5);

              return LineTooltipItem(
                '${isAirQuality ? "Air Quality" : "Usage"}\n${value.toStringAsFixed(1)} ${isAirQuality ? "ppm" : "units"}',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: true,
        touchSpotThreshold: 20,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: airQualitySpots,
          isCurved: true,
          color: Colors.blue,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 0.5,
                color: Colors.blue.shade600,
                strokeWidth: 0,
                strokeColor: Colors.white,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.blue.withOpacity(0.2),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue.withOpacity(0.2),
                Colors.blue.withOpacity(0.0),
              ],
            ),
          ),
        ),
        LineChartBarData(
          spots: usageSpots,
          isCurved: true,
          color: Colors.amber,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
            getDotPainter: (spot, percent, barData, index) {
              return FlDotCirclePainter(
                radius: 0.5,
                color: Colors.amber,
                strokeWidth: 0,
                strokeColor: Colors.amber,
              );
            },
          ),
          belowBarData: BarAreaData(
            show: true,
            color: Colors.amber.withOpacity(0.2),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.amber.withOpacity(0.5),
                Colors.amber.withOpacity(0.0),
              ],
            ),
          ),
        ),
        LineChartBarData(
          spots: [
            FlSpot(0, 50),
            FlSpot((airQualityData.length - 1).toDouble(), 50),
          ],
          isCurved: false,
          color: Colors.red.shade400,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          dashArray: [5, 5],
        ),
      ],
    );
  }
}

class AlertAndNotificationWidget extends StatelessWidget {
  const AlertAndNotificationWidget({
    super.key,
    required this.data,
  });

  final DashboardData? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(47),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Alerts & Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Text(
                    "Date & Time",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(
                    "Condition",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Text(
                    "Building",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...List.generate(data!.airQualityData.length, (index) {
            final airDta = data!.airQualityData[index];
            return Container(
              padding: EdgeInsets.only(
                  bottom: index == data!.airQualityData.length - 1 ? 0 : 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      DateFormat('yyyy-MM-dd  HH:mm:ss')
                          .format(airDta.timestamp),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      airDta.airQuality > airDta.threshold
                          ? "High Air Quality Alert"
                          : "Normal",
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      airDta.usage > airDta.threshold
                          ? "Building A"
                          : "Building B",
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}
