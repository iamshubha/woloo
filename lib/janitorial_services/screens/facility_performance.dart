import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/client_flow/screens/dashbaord/data/model/dashboard_task_model.dart';
import 'package:woloo_smart_hygiene/janitorial_services/widgets/ai_summary.dart';

class IotLogs extends StatelessWidget {
  final TaskStatusDistribution? taskStatusDistribution;
  // final String avgppmTimeRangeInsights;
  const IotLogs(
      {super.key,
      // required this.avgppmTimeRangeInsights,
      this.taskStatusDistribution});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            flex: 16,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey, spreadRadius: 2, blurRadius: 10),
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Facility Performance",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.sp,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: 30,
                                color: Colors.cyan[200],
                                radius: 32,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: 20,
                                color: Colors.lightBlueAccent,
                                radius: 32,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: 15,
                                color: Colors.cyan[400],
                                radius: 32,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: 15,
                                color: Colors.cyan[800],
                                radius: 32,
                                showTitle: false,
                              ),
                              PieChartSectionData(
                                value: 20,
                                color: Colors.cyan[100],
                                radius: 32,
                                showTitle: false,
                              ),
                            ],
                            centerSpaceRadius: 45,
                            sectionsSpace: 4,
                            borderData: FlBorderData(show: false),
                          ),
                        ),
                        // Percentage Labels
                        Positioned(
                          top: 18,
                          child: _circleLabel("30%"),
                        ),
                        Positioned(
                          right: 10,
                          top: 55,
                          child: _circleLabel("20%"),
                        ),
                        Positioned(
                          right: 25,
                          bottom: 35,
                          child: _circleLabel("15%"),
                        ),
                        Positioned(
                          left: 25,
                          bottom: 35,
                          child: _circleLabel("15%"),
                        ),
                        Positioned(
                          left: 10,
                          top: 55,
                          child: _circleLabel("20%"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(width: 24),
          // const Spacer(),
          const Spacer(),
          // Expanded(
          //     flex: 16,
          //     child: AiSummaryCard(
          //         fontSize: 14, summary: avgppmTimeRangeInsights)),

          // Right Column
          // Expanded(
          //   flex: 16,
          //   child: SizedBox(),
          // ),
          // Expanded(
          //   child:
          //       AiSummaryCard(fontSize: 14, summary: avgppmTimeRangeInsights),
          // )
        ],
      ),
    );
  }

  // Helper for donut chart labels
  static Widget _circleLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Helper for task dashboard rows
  static Widget _taskRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper for IOT Product Card
  static Widget _iotProductCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF6B6B6B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Regular badge
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Regular",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "IOT Product",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Facility:\nWomen's Powder Room",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const SizedBox(height: 4),
          Text(
            "Tasks:\nCleaning is required",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const SizedBox(height: 4),
          Text(
            "Date & Time:\n11 Jul 2024 | 12:55:41 PM",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const Divider(color: Colors.lightBlueAccent, thickness: 2),
          const SizedBox(height: 4),
          Text(
            "Assign To:\nSakshi Sakshi",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const SizedBox(
            height: 60,
          ),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  "Regular",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "IOT Product",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Facility:\nWomen's Powder Room",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const SizedBox(height: 4),
          Text(
            "Tasks:\nCleaning is required",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const SizedBox(height: 4),
          Text(
            "Date & Time:\n11 Jul 2024 | 12:55:41 PM",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
          const Divider(color: Colors.lightBlueAccent, thickness: 2),
          const SizedBox(height: 4),
          Text(
            "Assign To:\nSakshi Sakshi",
            style: TextStyle(color: Colors.white, fontSize: 8.sp),
          ),
        ],
      ),
    );
  }
}
