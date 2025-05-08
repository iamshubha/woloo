import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/janitorial_services/screens/host_dashboard_screen.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';
import 'package:woloo_smart_hygiene/widgets/order_summery_bottomsheet.dart';

class ReviewOrderBottomsheet extends StatelessWidget {
  const ReviewOrderBottomsheet({
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
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          const XBottmSheetTopDecor(),
          const SizedBox(
            height: 20,
          ),
          CartHeader(
              imgPath: AppImages.checkout,
              title: "Checkout",
              subtitle: "Please choose your address and mode of payment"),
          const Divider(
            color: Colors.white,
          ),
          XDecoratedBox(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                Text(
                  "Address",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  "Home",
                  style: AppTextStyle.font14bold,
                ),
                Row(
                  children: [
                    Text(
                      "1234 Lane road, Area, Location, Landmark",
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 5.w),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          XDecoratedBox(
            child: Column(
              spacing: 10,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Payment Method",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                XPaymentTile(
                  paymentMethod: "UPI App",
                  imgPath: AppImages.upiIcon,
                ),
                XPaymentTile(
                  paymentMethod: "Credit/Debit Card",
                  imgPath: AppImages.creditCard,
                ),
                XPaymentTile(
                  paymentMethod: "Net Banking",
                  imgPath: AppImages.netbanking,
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white,
          ),
          LongLabeledButton(
            label: "Review Order",
            onTap: () {
              // OrderSummeryBottomSheet
              showModalBottomSheet(
                isScrollControlled: true,
                isDismissible: true, // <-- Allow tap outside to dismiss
                enableDrag: true, // <-- Allow swipe down to dismiss

                backgroundColor: Colors
                    .transparent, // Optional: if you want rounded corners to show correctly

                context: context,
                builder: (_) => OrderSummeryBottomSheet(), //AddressBottomSheet
              );
            },
          )
        ],
      ),
    );
  }
}
