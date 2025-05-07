import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';

class OrderSummeryBottomSheet extends StatelessWidget {
  const OrderSummeryBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          spacing: 10,
          children: [
            const XBottmSheetTopDecor(),
            // const SizedBox(
            //   height: 20,
            // ),
            CartHeader(
                imgPath: AppImages.list,
                title: "Order Summary",
                subtitle:
                    "Check the summary of your order here before paying"),
            const Divider(
              color: Colors.white,
            ),
            const CartItemCard(isSelected: false),
            const Divider(
              color: Colors.white,
            ),
            XDecoratedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  const EditHeader(
                    label: "Delivery Address",
                  ),
                  const Text(
                    "Home",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "1234 Lane road, Area, Location, Landmark",
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ],
              ),
            ),
            XDecoratedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  const EditHeader(label: "Payment Details"),
                  Row(
                    children: [
                      SizedBox(
                          height: 40,
                          width: 40,
                          child: Image.asset(AppImages.upiIcon)),
                      const Text(
                        "UPI App",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const PricingCalculate(
              isHeader: true,
            ),
            const Divider(
              color: Colors.white,
            ),
            const LongLabeledButton(label: "Pay via [payment method]")
          ]),
    );
  }
}
