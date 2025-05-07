import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: const BoxDecoration(color: Colors.white),
        child: const LongLabeledButton(
          label: "Checkout",
        ),
      ),
      appBar: const BackAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          spacing: 16.h,
          children: [
            CartHeader(
              imgPath: AppImages.cart,
              title: "Cart",
              subtitle: 'Checkout you purchases from here',
            ),
            ListView.builder(
              shrinkWrap:
                  true, // Ensures ListView takes only the required space
              physics:
                  const NeverScrollableScrollPhysics(), // Prevents nested scrolling
              itemCount: 5, // Replace with your cart item count
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: const CartItemCard(),
                );
              },
            ),
            const Divider(),
            const ApplyPromo(),
            const Divider(),
            const PricingCalculate(),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class LongLabeledButton extends StatelessWidget {
  const LongLabeledButton({
    super.key,
    this.onTap,
    required this.label,
    this.color = AppColors.lightCyanColor,
  });
  final VoidCallback? onTap;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 30.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: color,
        ),
        child: Center(
            child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
        )),
      ),
    );
  }
}

class PricingCalculate extends StatelessWidget {
  const PricingCalculate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return XDecoratedBox(
        child: Column(
      children: [
        const ItemNamePrice(
          item: "Item Total",
          price: "Rs. 799",
        ),
        const ItemNamePrice(
          item: "Discount",
          price: "Rs. 50",
        ),
        const ItemNamePrice(
          item: "Item Total",
          price: "Rs. 749",
        ),
        const Divider(),
        ItemNamePrice(
          item: "Grand Total",
          price: "Rs. 799",
          itemStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}

class ItemNamePrice extends StatelessWidget {
  const ItemNamePrice({
    super.key,
    required this.item,
    required this.price,
    this.itemStyle,
  });
  final String item;
  final String price;
  final TextStyle? itemStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          item,
          style: itemStyle ??
              TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(
          price,
          style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textgreyColor),
        ),
      ],
    );
  }
}

class XDecoratedBox extends StatelessWidget {
  const XDecoratedBox({
    super.key,
    required this.child,
    this.padding = 12,
  });
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.w),
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
      child: child,
    );
  }
}

class XDesignedTextField extends StatelessWidget {
  const XDesignedTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.validator,
  });

  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        fillColor: AppColors.themeBackground,
        filled: true,
        hintText: hintText,
        hintStyle: AppTextStyle.font12,
        border: InputBorder.none,
      ),
    );
  }
}

class ApplyPromo extends StatelessWidget {
  const ApplyPromo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        spacing: 8,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(AppImages.salePercentage),
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                isDense: true,
                isCollapsed: true,
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(),
                hintText: "Enter Promocode",
              ),
            ),
          ),
          const CyanTextButton(
            label: "Apply",
          )
        ],
      ),
    );
  }
}

class CyanTextButton extends StatelessWidget {
  const CyanTextButton({
    super.key,
    this.onTap,
    required this.label,
  });

  final VoidCallback? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 6.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: AppColors.lightCyanColor,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
        ),
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  const CartItemCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Feather Toilet Seat",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Handle delete action
                      },
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(AppImages.deleteLogo),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 4.h),
                Text(
                  "Size: M",
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs. 799",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const CartAddRemove()
                  ],
                ),
              ],
            ),
          ),
          // Quantity and Delete Button
        ],
      ),
    );
  }
}

class CartHeader extends StatelessWidget {
  const CartHeader({
    super.key,
    required this.imgPath,
    required this.title,
    required this.subtitle,
  });
  final String imgPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(imgPath),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 10.sp),
            ),
          ],
        )
      ],
    );
  }
}
