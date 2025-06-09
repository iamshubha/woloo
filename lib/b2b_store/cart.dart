import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/product_details.dart';
import 'package:woloo_smart_hygiene/utils/app_color.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/utils/app_textstyle.dart';
import 'package:woloo_smart_hygiene/utils/logger.dart';
import 'package:woloo_smart_hygiene/widgets/boxes/cart_item.dart';

import '../widgets/review_order_bottomsheet.dart';
import 'widgets/radio_labeled_tile.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // final
  Razorpay razorpay = Razorpay();
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  bool _isDataLoaded = false;
  CartModel? cartModel;
  bool isExpressBooking = false;
  @override
  void initState() {
    _b2bStoreBloc.add(const GetCartData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _b2bStoreBloc,
        listener: (context, state) {
          // print("dssa $state");
          if (state is CartLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is CartSuccess) {
            // _b2bStoreBloc.add(const GetCartData());
            setState(() {
              print(state.cartData.cart);
              // _addressesData = state.addressesData;
              // _b2bStoreHomePage = state.dashboardData;
              cartModel = state.cartData;
              _isDataLoaded = true;
              // _dashboardData = state.dashboardData;
            });
            EasyLoading.dismiss();
          }
          if (state is CartError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
          if (state is ReadyToShip) {
            EasyLoading.dismiss();
            showCartBottomSheet(context);
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
              bottomSheet: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: const BoxDecoration(color: Colors.white),
                child: LongLabeledButton(
                  onTap: () {
                    _b2bStoreBloc.add(const ProceedToShip());
                  },
                  label: "Checkout",
                ),
              ),
              appBar: const BackAppBar(),
              body: !_isDataLoaded
                  ? Container()
                  : SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 20.h),
                      child: Column(
                        spacing: 16.h,
                        children: [
                          CartHeader(
                            imgPath: AppImages.cart,
                            title: "Cart",
                            subtitle: 'Checkout you purchases from here',
                          ),
                          const Divider(),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Total Items: ${cartModel?.cart.items.length} Unit",
                              style: AppTextStyle.font14bold,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              XRadioTile(
                                onTap: () {
                                  isExpressBooking = !isExpressBooking;
                                  setState(() {});
                                },
                                isSelected: !isExpressBooking,
                                title: "Normal Shipping",
                                subTitle: "7-10 Days",
                              ),
                              XRadioTile(
                                onTap: () {
                                  isExpressBooking = !isExpressBooking;
                                  setState(() {});
                                },
                                isSelected: isExpressBooking,
                                title: "Express Shipping+ Rs.75",
                                subTitle: "2-3 Days",
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap:
                                true, // Ensures ListView takes only the required space
                            physics:
                                const NeverScrollableScrollPhysics(), // Prevents nested scrolling
                            itemCount: cartModel?.cart.items
                                .length, // Replace with your cart item count
                            itemBuilder: (context, index) {
                              final item = cartModel?.cart.items[index];
                              int count = item?.quantity ?? 0;

                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: CartItemCard(
                                  onDelete: () {
                                    _b2bStoreBloc.add(
                                        DeleteItemReq(itemId: item?.id ?? ""));
                                  },
                                  item: item,
                                  onAdd: () {
                                    count++;
                                    _b2bStoreBloc.add(AddRemoveItemReq(
                                        count: count, itemId: item?.id ?? ""));
                                  },
                                  onRemove: () {
                                    count--;
                                    // logger.w("Count: $count");
                                    if (count > 0) {
                                      _b2bStoreBloc.add(AddRemoveItemReq(
                                          count: count,
                                          itemId: item?.id ?? ""));
                                    } else {
                                      logger.w("$count delete");
                                      _b2bStoreBloc.add(DeleteItemReq(
                                          itemId: item?.id ?? ""));
                                    }
                                  },
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: const [
                                  BoxShadow(
                                    color: AppColors.textgreyColor,
                                    blurRadius: 4,
                                    offset: Offset(0, 1),
                                  ),
                                ]),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Image.asset(AppImages.appLogo),
                                    ),
                                    Text(
                                      "Redeem your Woloo Points",
                                      style: AppTextStyle.font13w7,
                                    ),
                                  ],
                                ),
                                Text(
                                  "You have 210 Woloo Points to Redeem",
                                  style: AppTextStyle.font13w7
                                      .copyWith(color: AppColors.greyBorder),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Redeem 10 woloo points for Rs. 10",
                                      style: AppTextStyle.font10bold.copyWith(
                                          color: AppColors.greyBorder),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightCyanColor,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          "Apply",
                                          style: AppTextStyle.font14bold,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const ApplyPromo(),
                          const Divider(),
                          PricingCalculate(
                            total: cartModel?.cart.total,
                            subTotal: cartModel?.cart.subtotal,
                            discount: cartModel?.cart.discountTotal,
                            shipping: cartModel?.cart.shippingTotal,
                            itemTotal: cartModel?.cart.itemTotal,
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ));
        });
  }

  Future<dynamic> showCartBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true, // <-- Allow tap outside to dismiss
      enableDrag: true, // <-- Allow swipe down to dismiss

      backgroundColor: Colors
          .transparent, // Optional: if you want rounded corners to show correctly

      context: context,
      builder: (_) => const ReviewOrderBottomsheet(), //AddressBottomSheet
    );
  }
}

class LongLabeledButton extends StatelessWidget {
  const LongLabeledButton({
    super.key,
    required this.onTap,
    required this.label,
    this.color = AppColors.lightCyanColor,
    this.height = 30,
  });
  final VoidCallback onTap;
  final String label;
  final Color color;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height.h,
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
    this.total,
    this.subTotal,
    this.discount,
    this.itemTotal,
    this.shipping,
    this.isHeader = false,
  });
  final int? total;
  final int? subTotal;
  final int? discount;
  final int? itemTotal;
  final int? shipping;

  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    return XDecoratedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isHeader) ...[
          Text(
            "Order Summary",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
        ItemNamePrice(
          item: "Item Total",
          price: "Rs. $itemTotal",
        ),
        ItemNamePrice(
          item: "Discount",
          price: "Rs. $discount",
        ),
        shipping != 0
            ? ItemNamePrice(
                item: "Shipping",
                price: "Rs. $shipping",
              )
            : const SizedBox(),
        ItemNamePrice(
          item: "Item Total",
          price: "Rs. $subTotal",
        ),
        const Divider(),
        ItemNamePrice(
          item: "Grand Total",
          price: "Rs. $total",
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
    this.radius = 16,
  });
  final Widget child;
  final double padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        boxShadow: [
          // BoxShadow(
          //   color: Colors.grey.withOpacity(0.1),
          //   blurRadius: 5,
          //   spreadRadius: 1,
          //   offset: const Offset(0, 3),
          // ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 1, // Spread effect
            blurRadius: 10, // Blur effect
            offset: const Offset(0, 5), // Bottom shadow
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
        Flexible(
          child: Column(
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
          ),
        )
      ],
    );
  }
}
