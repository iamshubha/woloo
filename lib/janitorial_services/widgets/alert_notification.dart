import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';

import '../model/iotdata_model.dart';

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
          ...List.generate(data!.alertsNotification.length, (index) {
            final alert = data!.alertsNotification[index]['condition'];
            return Container(
              padding: EdgeInsets.only(
                  bottom:
                      index == data!.alertsNotification.length - 1 ? 0 : 30),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: Text(
                      DateFormat('yyyy-MM-dd  HH:mm:ss').format(DateTime.now()),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      alert.toString(),
                      style: const TextStyle(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Building A",
                      style: TextStyle(fontSize: 10),
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

class SegmentedCircularChart extends StatelessWidget {
  final double score;
  final String label;

  const SegmentedCircularChart({
    super.key,
    required this.score,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    // Define your segments (values and colors)
    final List<PieChartSectionData> sections = [
      PieChartSectionData(
        value: 25,
        color: Colors.grey[700],
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 25,
        color: Colors.lightBlueAccent,
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 25,
        color: Colors.cyan[200],
        radius: 18,
        showTitle: false,
      ),
      PieChartSectionData(
        value: 25,
        color: Colors.grey[300],
        radius: 18,
        showTitle: false,
      ),
    ];

    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections,
              startDegreeOffset: 220,
              centerSpaceRadius: 55,
              sectionsSpace: 8,
              borderData: FlBorderData(
                show: false,
              ),
              pieTouchData: PieTouchData(enabled: false),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                score.toStringAsFixed(1),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
