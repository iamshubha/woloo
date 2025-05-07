import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
          color:
              const Color.fromARGB(255, 204, 203, 203).withValues(alpha: 0.75),
          borderRadius: BorderRadius.vertical(top: Radius.circular(40.r))),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          const XBottmSheetTopDecor(),
          const SizedBox(
            height: 20,
          ),
          CartHeader(
            imgPath: AppImages.cart,
            title: "Cart",
            subtitle: 'Checkout you purchases from here',
          ),
          const Divider(
            color: Colors.white,
          ),
          const CartItemCard(),
          const Divider(
            color: Colors.white,
          ),
          const ApplyPromo(),
          const Divider(
            color: Colors.white,
          ),
          const PricingCalculate(),
          const Divider(
            color: Colors.white,
          ),
          const Row(
            spacing: 10,
            children: [
              Expanded(child: LongLabeledButton(label: "Checkout")),
              Expanded(
                  child: LongLabeledButton(
                label: "Keep Shopping",
                color: Colors.white,
              )),
            ],
          )
        ],
      ),
    );
  }
}
