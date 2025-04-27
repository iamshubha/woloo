import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/monitor-iot.dart';
import 'package:woloo_smart_hygiene/screens/common_widgets/image_provider.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_constants.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

import '../../utils/app_images.dart';
import '../model/iotdata_model.dart';

class WalkChartScreen extends StatefulWidget {
  const WalkChartScreen({super.key});

  @override
  State<WalkChartScreen> createState() => _WalkChartScreenState();
}

class _WalkChartScreenState extends State<WalkChartScreen> {
  DashboardData? _dashboardData;
  bool _isLoading = false;
  String _error = '';
  final String _timeFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    _fetchDashboardData();
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
      body: SafeArea(child: Builder(builder: (context) {
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
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // HeaderSection(
              //   username: data.username,
              //   userRole: data.userRole,
              //   lastUpdated: data.lastUpdated,
              //   trialDaysLeft: data.trialDaysLeft,
              // ),
              const SizedBox(height: 16),
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
              const WahScore(),
              const SizedBox(height: 16),
              const WalkIn(),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.textgreyColor,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Shop",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.boldTextColor),
                        ),
                        Container(
                          width: 84.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(25)),
                          child: const Center(child: Text("Go")),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(
                        height: 99.h,
                        child: ListView.separated(
                            itemCount: 20,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 10,
                                ),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 99.h,
                                width: 99.h,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  color: AppColors.dialogueBackground,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              );
                            })),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
        );
      })),
    );
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
}

class WalkIn extends StatelessWidget {
  const WalkIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: AppColors.textgreyColor,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                "Total No. of Walk-in’s",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Container(
                width: 84.w,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(25)),
                child: const Center(child: Text("Check")),
              )
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              3,
              (index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.dialogueBackground,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  children: [
                    const Text(
                      "last 6 hrs",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      Text(
                        "532",
                        style: TextStyle(
                          fontSize: 16.sp,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "↑ 356%",
                        style: TextStyle(
                            fontSize: 10.sp, color: AppColors.greenTextColor),
                      )
                    ])
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WahScore extends StatelessWidget {
  const WahScore({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
              color: AppColors.textgreyColor,
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ]),
      child: Column(
        children: [
          Image.asset(AppImages.wahScore),
          const SizedBox(height: 16),
          const Divider(color: AppColors.textgreyColor),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.textgreyColor1,
                radius: 12,
                child: Image.asset(AppImages.greenSmily),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 14,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You are doing very good!",
                      style: TextStyle(
                          color: AppColors.textgreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Your score is amongst the top hosts in your area!",
                      style: TextStyle(
                          color: AppColors.textgreyColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    borderRadius: BorderRadius.circular(25)),
                child: const Text("Inspect"),
              )
            ],
          )
        ],
      ),
    );
  }
}
