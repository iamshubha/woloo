import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines_plus/timelines_plus.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/ecom.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final timeLineList = [
      "Order Placed",
      "Order Accepted",
      "Order Shipped",
      "Order Delevered"
    ];
    return Scaffold(
      appBar: const BackAppBar(),
      body: Stack(
        children: [
          Padding(
            // padding: const EdgeInsets.all(8.0),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              spacing: 16.h,
              children: [
                CartHeader(
                    imgPath: AppImages.list,
                    title: "Order Details ",
                    subtitle: "Check or modify the details of your order here"),
                OrderStatusCard(
                  timeLineList: timeLineList,
                ),
                // const Spacer()
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 00,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.w),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.themeBackground,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.greyShadowColor,
                    blurRadius: 5.0,
                    spreadRadius: 0.5,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  XNavBarItems(
                    imageUrl: AppImages.homeIcon,
                    title: "Home",
                  ),
                  XNavBarItems(
                    imageUrl: AppImages.products,
                    title: "Products",
                  ),
                  XNavBarItems(
                    imageUrl: AppImages.monitoring,
                    title: "Monitoring",
                  ),
                  XNavBarItems(
                    imageUrl: AppImages.services,
                    title: "Services",
                  ),
                  XNavBarItems(
                    imageUrl: AppImages.profileIcon,
                    title: "Profile",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderStatusCard extends StatelessWidget {
  const OrderStatusCard({super.key, required this.timeLineList});
  final List<String> timeLineList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Details
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  AppImages.item, // Replace with your product image
                  height: 60.h,
                  width: 60.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.w),
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feather Toilet Seat",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Size: M  |  QTY: 3",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "Rs. 799",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 60.h,
            child: Timeline.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (c, i) {
                  return TimelineTile(
                    nodePosition: 0,
                    contents: SizedBox(
                      width: 150,
                      child: Text(
                        timeLineList[i],
                        textAlign: TextAlign.center,
                      ),
                    ),
                    mainAxisExtent: 80,
                    node: TimelineNode(
                      startConnector: i != 0
                          ? const SolidLineConnector(
                              color: AppColors.lightCyanColor,
                            )
                          : null,
                      endConnector: i + 1 < (timeLineList.length)
                          ? const SolidLineConnector(
                              color: AppColors.lightCyanColor,
                            )
                          : null,
                      indicator: DotIndicator(
                        size: 23.h,
                        color: i == 0 ? AppColors.greenBold : AppColors.orange,
                        child: i == 0
                            ? const Icon(
                                Icons.check,
                                size: 12,
                              )
                            : null,
                      ),
                    ),
                  );
                },
                itemCount: 4),
          ),

          SizedBox(height: 12.h),
          // Cancel Button
          Center(
            child: GestureDetector(
              onTap: () {
                // Handle cancel action
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
