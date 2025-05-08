import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_bloc.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_event.dart';
import 'package:woloo_smart_hygiene/b2b_store/bloc/b2b_store_state.dart';
import 'package:woloo_smart_hygiene/b2b_store/cart.dart';
import 'package:woloo_smart_hygiene/b2b_store/models/cart.dart';
import 'package:woloo_smart_hygiene/utils/app_images.dart';
import 'package:woloo_smart_hygiene/widgets/address_change_bottomsheet.dart';
import 'package:woloo_smart_hygiene/widgets/review_order_bottomsheet.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  final B2bStoreBloc _b2bStoreBloc = B2bStoreBloc();
  bool _isDataLoaded = false;
  CartModel? cartModel;
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
          if (state is CartLoading) {
            EasyLoading.show(status: state.message);
          }
          if (state is CartSuccess) {
            EasyLoading.dismiss();
            setState(() {
              print(state.cartData.cart);
              // _addressesData = state.addressesData;
              // _b2bStoreHomePage = state.dashboardData;
              cartModel = state.cartData;
              _isDataLoaded = true;
              // _dashboardData = state.dashboardData;
            });
          }

          if (state is CartError) {
            EasyLoading.dismiss();
            EasyLoading.showError(state.error);
          }
        },
        builder: (context, snapshot) {
          return !_isDataLoaded
              ? Container()
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(40.r))),
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                    child: cartModel?.cart?.items.isEmpty ?? true
                        ? Container()
                        : Column(
                            spacing: 16.h,
                            children: [
                              const XBottmSheetTopDecor(),
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
                                itemCount: cartModel?.cart?.items
                                    .length, // Replace with your cart item count
                                itemBuilder: (context, index) {
                                  final item = cartModel?.cart?.items[index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.h),
                                    child: CartItemCard(
                                      item: item,
                                    ),
                                  );
                                },
                              ),
                              const Divider(),
                              const ApplyPromo(),
                              const Divider(),
                              PricingCalculate(
                                total: cartModel?.cart?.total,
                                subTotal: cartModel?.cart?.subtotal,
                                discount: cartModel?.cart?.discountTotal,
                                itemTotal: cartModel?.cart?.itemTotal,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                spacing: 10,
                                children: [
                                  Expanded(
                                      child: LongLabeledButton(
                                    label: "Checkout",
                                    onTap: () {
                                      Navigator.pop(context);
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        isDismissible:
                                            true, // <-- Allow tap outside to dismiss
                                        enableDrag:
                                            true, // <-- Allow swipe down to dismiss

                                        backgroundColor: Colors
                                            .transparent, // Optional: if you want rounded corners to show correctly

                                        context: context,
                                        builder: (_) =>
                                            const ReviewOrderBottomsheet(), //AddressBottomSheet
                                      );
                                    },
                                  )),
                                  Expanded(
                                      child: LongLabeledButton(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    label: "Keep Shopping",
                                    color: Colors.white,
                                  )),
                                ],
                              )
                            ],
                          ),
                  ),
                );
        });
  }
}
